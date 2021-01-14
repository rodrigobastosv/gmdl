import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entity/model/models.dart';
import '../../extension/datetime_extensions.dart';
import '../../repository/stop_repository.dart';
import '../route/route_cubit.dart';
import '../../utils/utils.dart';

part 'stop_state.dart';

class StopCubit extends Cubit<StopState> {
  StopCubit({
    @required this.stop,
    @required StopRepository repository,
    @required RouteCubit routeCubit,
  })  : assert(stop != null),
        assert(repository != null),
        assert(routeCubit != null),
        _repository = repository,
        _routeCubit = routeCubit,
        super(StopInitial());

  StopModel stop;
  final StopRepository _repository;
  final RouteCubit _routeCubit;

  Future<void> arriveStop() async {
    final route = _routeCubit.route;
    final actualArrival = DateTime.now().toUtcAsString;
    try {
      await _repository.arriveStop(
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
      final departedStop = await _repository.departStop(
        routeId: route.id,
        stop: stop,
        actualDeparture: actualDeparture,
      );
      if (departedStop) {
        stop = stop.copyWith(actualDeparture: actualDeparture);
        _routeCubit.updateRouteDueStopChange(stop);
        emit(DepartedStopSuccess(stop));
      } else {
        emit(DepartedStopFailed());
      }
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
        stop: stop,
      );
      emit(ClonedStopSuccess(stop));
      _routeCubit.updateRouteDueClonedStop(stop);
    } on Exception {
      emit(DepartedStopFailed());
    }
  }
}
