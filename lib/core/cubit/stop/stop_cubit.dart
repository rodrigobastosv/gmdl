import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entity/enum/enums.dart';
import '../../entity/model/cancel_code_model.dart';
import '../../entity/model/models.dart';
import '../../exception/exceptions.dart';
import '../../global/global_info.dart';
import '../../repository/stop_repository.dart';
import '../../utils/time_utils.dart';
import '../../utils/utils.dart';
import '../cubits.dart';

part 'stop_state.dart';

class StopCubit extends Cubit<StopState> {
  StopCubit({
    @required this.stop,
    @required StopRepository repository,
    @required RouteCubit routeCubit,
    @required GpsCubit gpsCubit,
    @required GlobalInfo globalInfo,
  })  : assert(stop != null),
        assert(repository != null),
        assert(routeCubit != null),
        assert(gpsCubit != null),
        assert(globalInfo != null),
        _repository = repository,
        _routeCubit = routeCubit,
        _gpsCubit = gpsCubit,
        _globalInfo = globalInfo,
        super(StopInitial());

  final StopRepository _repository;
  final RouteCubit _routeCubit;
  final GpsCubit _gpsCubit;
  final GlobalInfo _globalInfo;

  StopModel stop;
  int serviceTimeInSeconds = 0;
  StreamSubscription timeSubscription;

  List<CancelCodeModel> get allCancelCodes => _globalInfo.cancelCodes;

  List<UndeliverableCodeModel> get allUndeliveableCodes =>
      _globalInfo.undeliverableCodes;

  Future<void> arriveStop(String actualArrival) async {
    final route = _routeCubit.route;
    try {
      emit(StopArriveLoad());
      _repository.arriveStop(
        routeId: route.id,
        stop: stop,
        actualArrival: actualArrival,
      );
      _gpsCubit.sendStopGpsInfo(
        StopEvent.ARRIVE_STOP,
        routeId: route.id,
        stopKey: stop.key,
      );
      stop = stop.copyWith(actualArrival: actualArrival);
      startServiceTime();
      _routeCubit.updateRouteDueStopChange(stop);
      emit(StopArriveSuccess());
    } on ArriveStopException catch (e) {
      emit(StopArriveFailure(e.errorMessage));
    }
  }

  void startServiceTime() {
    if (stop.isPending) {
      if (stop.hasBeenArrived) {
        serviceTimeInSeconds = getStopServiceTimeInSeconds(stop);
        emit(StopServiceTimeUpdate(serviceTimeInSeconds));
        timeSubscription = Stream.periodic(ONE_SECOND).listen((_) {
          serviceTimeInSeconds++;
          emit(StopServiceTimeUpdate(serviceTimeInSeconds));
        });
      } else {
        serviceTimeInSeconds = 0;
      }
    }
  }

  Future<void> departStop(String actualDeparture) async {
    final route = _routeCubit.route;
    try {
      emit(StopDepartLoad());
      _repository.departStop(
        routeId: route.id,
        stop: stop,
        actualDeparture: actualDeparture,
      );
      _gpsCubit.sendStopGpsInfo(
        StopEvent.DEPART_STOP,
        routeId: route.id,
        stopKey: stop.key,
      );
      stop = stop.copyWith(actualDeparture: actualDeparture);
      _routeCubit.updateRouteDueStopChange(stop);
      emit(StopDepartSuccess(stop));
    } on DepartStopException catch (e) {
      emit(StopDepartFailure(e.errorMessage));
    }
  }

  Future<void> cloneStop(String cloneDate) async {
    final route = _routeCubit.route;
    try {
      emit(StopCloneLoad());
      final clonedStop = await _repository.cloneStop(
        routeId: route.id,
        stop: stop,
      );
      stop = cloneStopWithoutActuals(
        stopId: clonedStop.id,
        stopKey: clonedStop.key,
        plannedSequenceNum: clonedStop.plannedSequenceNum,
        cloneDate: cloneDate,
        stop: stop,
      );
      emit(StopCloneSuccess(stop));
      _routeCubit.updateRouteDueClonedStop(stop);
    } on CloneStopException catch (e) {
      emit(StopCloneFailure(e.errorMessage));
    }
  }

  Future<void> cancelStop({
    CancelCodeModel cancelCode,
    String actualCancel,
  }) async {
    final route = _routeCubit.route;
    try {
      emit(StopCancelLoad());
      _repository.cancelStop(
        routeId: route.id,
        actualCancel: actualCancel,
        cancelCode: cancelCode.id,
        stopKey: stop.key,
      );
      _gpsCubit.sendStopGpsInfo(
        StopEvent.CANCEL_STOP,
        routeId: route.id,
        stopKey: stop.key,
      );
      stop = stop.copyWith(
        canceled: true,
        cancelCode: cancelCode,
      );
      emit(StopCancelSuccess(stop));
      _routeCubit.updateRouteDueStopChange(stop);
    } on CancelStopException catch (e) {
      emit(StopCancelFailure(e.errorMessage));
    }
  }

  Future<void> undeliverStop({
    UndeliverableCodeModel undeliverableCode,
    String actualDeparture,
  }) async {
    final route = _routeCubit.route;
    try {
      emit(StopUndeliverLoad());
      _repository.undeliverStop(
        routeId: route.id,
        undeliverableCode: undeliverableCode.id,
        actualDeparture: actualDeparture,
        stopKey: stop.key,
      );
      stop = stop.copyWith(
        actualDeparture: actualDeparture,
        undeliverableCode: undeliverableCode,
      );
      emit(StopUndeliverSuccess(stop));
      _routeCubit.updateRouteDueStopChange(stop);
    } on UndeliverStopException catch (e) {
      emit(StopUndeliverFailure(e.errorMessage));
    }
  }

  Future<void> redeliverStop({
    UndeliverableCodeModel undeliverableCode,
    String actualDeparture,
    String suggestedTimeWindow,
  }) async {
    final route = _routeCubit.route;
    try {
      emit(StopRedeliverLoad());
      final newStopKey = generateNewStopKey();
      _repository.redeliverStop(
        routeId: route.id,
        undeliverableCode: undeliverableCode.id,
        actualDeparture: actualDeparture,
        undeliveredStopKey: stop.key,
        newStopKey: newStopKey,
        suggestedTimeWindow: suggestedTimeWindow,
      );
      final lastStopById = getLastStopOrderedById(route);
      final lastPlannedStop = getLastPlannedStop(route);
      final stopToRedeliver = stop.copyWith(
        id: lastStopById.id + 1,
        key: newStopKey,
        plannedSequenceNum: lastPlannedStop.plannedSequenceNum + 1,
        actualArrival: null,
      );
      _routeCubit.updateRouteDueRedeliverStop(stopToRedeliver);
      stop = stop.copyWith(
        actualDeparture: actualDeparture,
        undeliverableCode: undeliverableCode,
        redeliveryStop: stopToRedeliver,
      );
      _routeCubit.updateRouteDueStopChange(stop);
      emit(StopRedeliverSuccess(stop));
    } on RedeliverStopException catch (e) {
      emit(StopRedeliverFailure(e.errorMessage));
    }
  }

  @override
  Future<void> close() {
    timeSubscription?.cancel();
    return super.close();
  }
}
