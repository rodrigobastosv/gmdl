import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../utils/route_utils.dart';

import '../../entity/enum/enums.dart';
import '../../entity/model/models.dart';
import '../../repository/repositories.dart';
import '../../selector/route_selectors.dart';
import '../../store/store_provider.dart';
import '../../extension/datetime_extensions.dart';
part 'route_state.dart';

class RouteCubit extends Cubit<RouteState> {
  RouteCubit({
    @required this.route,
    @required RouteRepository repository,
    @required this.storeProvider,
  })  : assert(repository != null),
        assert(storeProvider != null),
        _repository = repository,
        super(RouteInitial());

  RouteModel route;
  final RouteRepository _repository;
  final StoreProvider storeProvider;

  String get driverName => storeProvider.driverInfo.name;

  Future<void> startRoute() async {
    try {
      emit(StartingRoute());
      final routeStarted = await _repository.startRoute(route.id);
      if (routeStarted) {
        route = route.copyWith(status: RouteStatus.STARTED);
        emit(RouteStartedSuccess());
      } else {
        emit(RouteStartFailed());
      }
    } on Exception {
      emit(RouteStartFailed());
    }
  }

  Future<void> departOrigin() async {
    try {
      emit(DepartingOrigin());
      final departedOrigin = await _repository.departOrigin(route.id);
      if (departedOrigin) {
        route = route.copyWith(status: RouteStatus.DEPARTED_ORIGIN);
        emit(DepartOriginSuccess());
      } else {
        emit(DepartOriginFailed());
      }
    } on Exception {
      emit(DepartOriginFailed());
    }
  }

  Future<void> arriveStop(StopModel stop) async {
    try {
      emit(ArrivingStop());
      final actualArrival = DateTime.now().toUtcAsString;
      final arrivedStop = await _repository.arriveStop(
        routeId: route.id,
        stop: stop,
        actualArrival: actualArrival,
      );
      if (arrivedStop) {
        final _updatedStop = stop.copyWith(actualArrival: actualArrival);
        emit(ArrivedStopSuccess(_updatedStop));
      } else {
        emit(ArrivedStopFailed());
      }
    } on Exception {
      emit(ArrivedStopFailed());
    }
  }

  void updateRouteDueStopChange(StopModel stop) {
    print('b');
    print(stop.id);
    route = updateRouteByStopChange(route, stop);
    emit(RouteUpdatedDueStopChange(stop));
    if (!hasPendingStops(route)) {
      emit(RouteHasNoPendingStops());
    }
  }

  Future<void> arriveWarehouse() async {
    try {
      emit(ArrivingWarehouse());
      final arrivedWarehouse = await _repository.arriveWarehouse(route.id);
      if (arrivedWarehouse) {
        emit(ArrivedWarehouseSuccess());
      } else {
        emit(ArrivedWarehouseFailed());
      }
    } on Exception {
      emit(ArrivedWarehouseFailed());
    }
  }

  Future<void> completeRoute() async {
    try {
      emit(CompletingRoute());
      final routeCompleted = await _repository.completeRoute(route.id);
      if (routeCompleted) {
        emit(RouteCompletedSuccess());
      } else {
        emit(RouteCompletedFailed());
      }
    } on Exception {
      emit(RouteCompletedFailed());
    }
  }
}
