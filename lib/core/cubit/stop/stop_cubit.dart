import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../route/route_cubit.dart';
import '../../entity/model/models.dart';
import '../../repository/stop_repository.dart';
import '../../extension/datetime_extensions.dart';
part 'stop_state.dart';

class StopCubit extends Cubit<StopState> {
  StopCubit({
    @required StopModel stop,
    @required StopRepository repository,
    @required RouteCubit routeCubit,
  })  : assert(stop != null),
        assert(repository != null),
        assert(routeCubit != null),
        _stop = stop,
        _repository = repository,
        _routeCubit = routeCubit,
        super(StopInitial());

  final StopModel _stop;
  final StopRepository _repository;
  final RouteCubit _routeCubit;

  Future<void> departStop() async {
    final route = _routeCubit.route;
    final actualDeparture = DateTime.now().toUtcAsString;
    try {
      emit(DepartingStop());
      final departedStop = await _repository.departStop(
        routeId: route.id,
        stop: _stop,
        actualDeparture: actualDeparture,
      );
      if (departedStop) {
        final _updatedStop = _stop.copyWith(actualDeparture: actualDeparture);
        emit(DepartedStopSuccess(_updatedStop));
        _routeCubit.updateRouteDueToDepartStop(_updatedStop);
      } else {
        emit(DepartedStopFailed());
      }
    } on Exception {
      emit(DepartedStopFailed());
    }
  }
}
