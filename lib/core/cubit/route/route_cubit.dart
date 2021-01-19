import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entity/enum/enums.dart';
import '../../entity/model/models.dart';
import '../../extension/datetime_extensions.dart';
import '../../repository/repositories.dart';
import '../../selector/route_selectors.dart';
import '../../store/store.dart';
import '../../utils/route_utils.dart';
import '../cubits.dart';

part 'route_state.dart';

class RouteCubit extends Cubit<RouteState> {
  RouteCubit({
    @required this.route,
    @required RouteRepository repository,
    @required this.store,
    @required NotificationCubit notificationCubit,
  })  : assert(repository != null),
        assert(store != null),
        assert(notificationCubit != null),
        _repository = repository,
        _notificationCubit = notificationCubit,
        super(RouteInitial());

  final RouteRepository _repository;
  final Store store;
  final NotificationCubit _notificationCubit;
  RouteModel route;
  StreamSubscription<NotificationState> _notificationSubscription;

  String get driverName => store.driverInfo.name;

  void initNotifications() {
    _notificationSubscription = _notificationCubit.listen((state) {
      if (state is NotificationReceived) {
        print('Process notification!');
      }
    });
    emit(RouteBeginListenNotifications());
  }

  @override
  Future<void> close() {
    _notificationSubscription.cancel();
    return super.close();
  }

  Future<void> startRoute() async {
    try {
      emit(StartingRoute());
      await _repository.startRoute(route.id);
      route = route.copyWith(status: RouteStatus.STARTED);
      emit(RouteStartedSuccess());
    } on Exception {
      emit(RouteStartFailed());
    }
  }

  Future<void> departOrigin() async {
    try {
      emit(DepartingOrigin());
      await _repository.departOrigin(route.id);
      route = route.copyWith(status: RouteStatus.DEPARTED_ORIGIN);
      emit(DepartOriginSuccess());
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
        route = updateRouteByStopChange(route, _updatedStop);
        emit(ArrivedStopSuccess(_updatedStop));
      } else {
        emit(ArrivedStopFailed());
      }
    } on Exception {
      emit(ArrivedStopFailed());
    }
  }

  void updateRouteDueStopChange(StopModel stop) {
    route = updateRouteByStopChange(route, stop);
    emit(RouteUpdatedDueStopChange(stop));
    if (!hasPendingStops(route)) {
      emit(RouteHasNoPendingStops());
    }
  }

  void updateRouteDueClonedStop(StopModel clonedStop) {
    route = updateRouteByAddStop(route, clonedStop);
    emit(RouteUpdatedDueStopClone(clonedStop));
  }

  void updateRouteDueRedeliverStop(StopModel newStop) {
    route = updateRouteByAddStop(route, newStop);
    emit(RouteUpdatedDueStopRedeliver(newStop));
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
      await _repository.completeRoute(route.id);
      route = route.copyWith(status: RouteStatus.COMPLETED);
      emit(RouteCompletedSuccess());
    } on Exception {
      emit(RouteCompletedFailed());
    }
  }
}
