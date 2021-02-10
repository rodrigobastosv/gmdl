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
    @required ClientCubit clientCubit,
    @required GpsCubit gpsCubit,
    @required GlobalInfo globalInfo,
  })  : assert(stop != null),
        assert(repository != null),
        assert(routeCubit != null),
        assert(clientCubit != null),
        assert(gpsCubit != null),
        assert(globalInfo != null),
        _repository = repository,
        _routeCubit = routeCubit,
        _clientCubit = clientCubit,
        _gpsCubit = gpsCubit,
        _globalInfo = globalInfo,
        super(StopInitial());

  final StopRepository _repository;
  final RouteCubit _routeCubit;
  final GpsCubit _gpsCubit;
  final ClientCubit _clientCubit;
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
      emit(ArrivingOnStop());
      _clientCubit.schedule(
        _repository.arriveStop(
          routeId: route.id,
          stop: stop,
          actualArrival: actualArrival,
        ),
      );
      _clientCubit.schedule(
        _gpsCubit.sendStopGpsInfo(
          StopEvent.ARRIVE_STOP,
          routeId: route.id,
          stopKey: stop.key,
        ),
      );
      stop = stop.copyWith(actualArrival: actualArrival);
      startServiceTime();
      _routeCubit.updateRouteDueStopChange(stop);
      emit(ArrivedStopSuccessOnStop());
    } on ArriveStopException catch (e) {
      emit(ArriveStopFailed(e.errorMessage));
    }
  }

  void startServiceTime() {
    if (stop.isPending) {
      if (stop.hasBeenArrived) {
        serviceTimeInSeconds = getStopServiceTimeInSeconds(stop);
        emit(ServiceTimeUpdated(serviceTimeInSeconds));
        timeSubscription = Stream.periodic(ONE_SECOND).listen((_) {
          serviceTimeInSeconds++;
          emit(ServiceTimeUpdated(serviceTimeInSeconds));
        });
      } else {
        serviceTimeInSeconds = 0;
      }
    }
  }

  Future<void> departStop(String actualDeparture) async {
    final route = _routeCubit.route;
    try {
      emit(DepartingStop());
      _clientCubit.schedule(
        _repository.departStop(
          routeId: route.id,
          stop: stop,
          actualDeparture: actualDeparture,
        ),
      );
      _clientCubit.schedule(
        _gpsCubit.sendStopGpsInfo(
          StopEvent.DEPART_STOP,
          routeId: route.id,
          stopKey: stop.key,
        ),
      );
      stop = stop.copyWith(actualDeparture: actualDeparture);
      _routeCubit.updateRouteDueStopChange(stop);
      emit(DepartedStopSuccess(stop));
    } on DepartStopException catch (e) {
      emit(DepartStopFailed(e.errorMessage));
    }
  }

  Future<void> cloneStop(String cloneDate) async {
    final route = _routeCubit.route;
    try {
      emit(CloningStop());
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
      emit(ClonedStopSuccess(stop));
      _routeCubit.updateRouteDueClonedStop(stop);
    } on CloneStopException catch (e) {
      emit(CloneStopFailed(e.errorMessage));
    }
  }

  Future<void> cancelStop({
    CancelCodeModel cancelCode,
    String actualCancel,
  }) async {
    final route = _routeCubit.route;
    try {
      emit(CancellingStop());
      _repository.cancelStop(
        routeId: route.id,
        actualCancel: actualCancel,
        cancelCode: cancelCode.id,
        stopKey: stop.key,
      );
      _clientCubit.schedule(
        _gpsCubit.sendStopGpsInfo(
          StopEvent.CANCEL_STOP,
          routeId: route.id,
          stopKey: stop.key,
        ),
      );
      stop = stop.copyWith(
        canceled: true,
        cancelCode: cancelCode,
      );
      emit(CanceledStopSuccess(stop));
      _routeCubit.updateRouteDueStopChange(stop);
    } on CancelStopException catch (e) {
      emit(CanceledStopFailed(e.errorMessage));
    }
  }

  Future<void> undeliverStop({
    UndeliverableCodeModel undeliverableCode,
    String actualDeparture,
  }) async {
    final route = _routeCubit.route;
    try {
      emit(UndeliveringStop());
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
      emit(UndeliveredStopSuccess(stop));
      _routeCubit.updateRouteDueStopChange(stop);
    } on UndeliverStopException catch (e) {
      emit(UndeliveredStopFailed(e.errorMessage));
    }
  }

  Future<void> redeliverStop({
    UndeliverableCodeModel undeliverableCode,
    String actualDeparture,
  }) async {
    final route = _routeCubit.route;
    try {
      emit(RedeliveringStop());
      final newStopKey = generateNewStopKey();
      _repository.redeliverStop(
        routeId: route.id,
        undeliverableCode: undeliverableCode.id,
        actualDeparture: actualDeparture,
        undeliveredStopKey: stop.key,
        newStopKey: newStopKey,
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
      emit(RedeliveredStopSuccess(stop));
    } on RedeliverStopException catch (e) {
      emit(RedeliveredStopFailed(e.errorMessage));
    }
  }

  @override
  Future<void> close() {
    timeSubscription?.cancel();
    return super.close();
  }
}
