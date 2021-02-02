import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entity/enum/enums.dart';
import '../../entity/model/models.dart';
import '../../exception/exceptions.dart';
import '../../extension/datetime_extensions.dart';
import '../../global/global_info.dart';
import '../../repository/repositories.dart';
import '../../selector/route_selectors.dart';
import '../../utils/route_utils.dart';
import '../cubits.dart';

part 'route_state.dart';

class RouteCubit extends Cubit<RouteState> {
  RouteCubit({
    @required this.route,
    @required RouteRepository repository,
    @required this.globalInfo,
    @required NotificationCubit notificationCubit,
  })  : assert(route != null),
        assert(repository != null),
        assert(globalInfo != null),
        assert(notificationCubit != null),
        _repository = repository,
        _notificationCubit = notificationCubit,
        super(RouteInitial());

  final RouteRepository _repository;
  final GlobalInfo globalInfo;
  final NotificationCubit _notificationCubit;

  RouteModel route;
  StreamSubscription<NotificationState> _notificationSubscription;

  String get driverName => globalInfo.driverInfo.name;

  String get token => _notificationCubit.fcmToken;

  void listenNotifications() {
    _notificationSubscription = _notificationCubit.listen((state) async {
      if (state is NotificationReceived) {
        final notification = state.notification;
        if (notification.action == NotificationAction.ROUTE_PLANNED_UPDATE) {
          try {
            final syncRoute =
                await _repository.syncRouteByNotification(route.id);
            route = mergeRoutes(route, syncRoute);
            emit(
              RouteUpdatedDueNotification(
                notificationId: notification.id,
                notificationAction: NotificationAction.ROUTE_PLANNED_UPDATE,
              ),
            );
          } on Exception {
            emit(
              FailedToUpdatedRouteByNotification(
                notificationId: notification.id,
                notificationAction: NotificationAction.ROUTE_PLANNED_UPDATE,
              ),
            );
          }
        }
      }
    });
    emit(RouteBeginListenNotifications());
  }

  @override
  Future<void> close() {
    _notificationSubscription?.cancel();
    return super.close();
  }

  Future<void> startRoute() async {
    try {
      emit(StartingRoute());
      await _repository.startRoute(route.id);
      route = route.copyWith(status: RouteStatus.STARTED);

      final proConfig = await _repository.fetchProConfig(route.id);
      if (proConfig != null) {
        route = route.copyWith(proactiveRouteOptConfig: proConfig);
        emit(ProConfigAppliedToRoute(proConfig));
      }

      emit(RouteStartedSuccess());
    } on StartRouteException catch (e) {
      emit(RouteStartFailed(e.errorMessage));
    }
  }

  Future<void> departOrigin() async {
    try {
      emit(DepartingOrigin());
      _repository.departOrigin(route.id);
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
      _repository.arriveStop(
        routeId: route.id,
        stop: stop,
        actualArrival: actualArrival,
      );
      final _updatedStop = stop.copyWith(actualArrival: actualArrival);
      route = updateRouteByStopChange(route, _updatedStop);
      emit(ArrivedStopSuccess(_updatedStop));
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
      _repository.arriveWarehouse(route.id);
      emit(ArrivedWarehouseSuccess());
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
