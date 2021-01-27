import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entity/model/cancel_code_model.dart';
import '../../entity/model/models.dart';
import '../../exception/exceptions.dart';
import '../../extension/datetime_extensions.dart';
import '../../global/global_info.dart';
import '../../repository/stop_repository.dart';
import '../../selector/route_selectors.dart';
import '../../utils/utils.dart';
import '../route/route_cubit.dart';

part 'stop_state.dart';

class StopCubit extends Cubit<StopState> {
  StopCubit({
    @required this.stop,
    @required StopRepository repository,
    @required RouteCubit routeCubit,
    @required GlobalInfo globalInfo,
  })  : assert(stop != null),
        assert(repository != null),
        assert(routeCubit != null),
        assert(globalInfo != null),
        _repository = repository,
        _routeCubit = routeCubit,
        _globalInfo = globalInfo,
        super(StopInitial());

  StopModel stop;
  final StopRepository _repository;
  final RouteCubit _routeCubit;
  final GlobalInfo _globalInfo;

  List<CancelCodeModel> get allCancelCodes => _globalInfo.cancelCodes;
  List<UndeliverableCodeModel> get allUndeliveableCodes =>
      _globalInfo.undeliverableCodes;

  Future<void> arriveStop() async {
    final route = _routeCubit.route;
    final actualArrival = DateTime.now().toUtcAsString;
    try {
      _repository.arriveStop(
        routeId: route.id,
        stop: stop,
        actualArrival: actualArrival,
      );
      stop = stop.copyWith(actualArrival: actualArrival);
      _routeCubit.updateRouteDueStopChange(stop);
      emit(ArrivedStopSuccess());
    } on Exception {
      emit(ArrivedStopFailed());
    }
  }

  Future<void> departStop() async {
    final route = _routeCubit.route;
    final actualDeparture = DateTime.now().toUtcAsString;
    try {
      emit(DepartingStop());
      _repository.departStop(
        routeId: route.id,
        stop: stop,
        actualDeparture: actualDeparture,
      );
      stop = stop.copyWith(actualDeparture: actualDeparture);
      _routeCubit.updateRouteDueStopChange(stop);
      emit(DepartedStopSuccess(stop));
    } on Exception {
      emit(DepartedStopFailed());
    }
  }

  Future<void> cloneStop() async {
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
        cloneDate: clonedStop.cloneDate,
        stop: stop,
      );
      emit(ClonedStopSuccess(stop));
      _routeCubit.updateRouteDueClonedStop(stop);
    } on Exception {
      emit(DepartedStopFailed());
    }
  }

  Future<void> cancelStop(CancelCodeModel cancelCode) async {
    final route = _routeCubit.route;
    try {
      emit(CancellingStop());
      final actualCancel = DateTime.now().toUtcAsString;
      _repository.cancelStop(
        routeId: route.id,
        actualCancel: actualCancel,
        cancelCode: cancelCode.id,
        stopKey: stop.key,
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

  Future<void> undeliverStop(UndeliverableCodeModel undeliverableCode) async {
    final route = _routeCubit.route;
    try {
      emit(UndeliveringStop());
      final actualDeparture = DateTime.now().toUtcAsString;
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
    } on CancelStopException catch (e) {
      emit(UndeliveredStopFailed(e.errorMessage));
    }
  }

  Future<void> redeliverStop(UndeliverableCodeModel undeliverableCode) async {
    final route = _routeCubit.route;
    try {
      emit(RedeliveringStop());
      final newStopKey = generateNewStopKey();
      final actualDeparture = DateTime.now().toUtcAsString;
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
    } on CancelStopException catch (e) {
      emit(RedeliveredStopFailed(e.errorMessage));
    }
  }
}
