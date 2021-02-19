import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../entity/dto/notification_dto.dart';
import '../../entity/enum/enums.dart';
import '../../entity/model/models.dart';
import '../../exception/exceptions.dart';
import '../../global/global_info.dart';
import '../../repository/repositories.dart';
import '../../service/services.dart';
import '../../utils/map_utils.dart';
import '../../utils/route_utils.dart';
import '../cubits.dart';

part 'route_state.dart';

class RouteCubit extends Cubit<RouteState> {
  RouteCubit({
    @required this.route,
    @required RouteRepository repository,
    @required GlobalInfo globalInfo,
    @required NotificationCubit notificationCubit,
    @required HosCubit hosCubit,
    @required GpsCubit gpsCubit,
    @required LaunchService launchService,
  })  : assert(route != null),
        assert(repository != null),
        assert(globalInfo != null),
        assert(notificationCubit != null),
        assert(hosCubit != null),
        assert(gpsCubit != null),
        assert(launchService != null),
        _repository = repository,
        _globalInfo = globalInfo,
        _notificationCubit = notificationCubit,
        _hosCubit = hosCubit,
        _gpsCubit = gpsCubit,
        _launchService = launchService,
        super(RouteInitial());

  final RouteRepository _repository;
  final GlobalInfo _globalInfo;
  final NotificationCubit _notificationCubit;
  final HosCubit _hosCubit;
  final GpsCubit _gpsCubit;
  final LaunchService _launchService;

  RouteModel route;
  Position lastPosition;
  StreamSubscription<NotificationState> _notificationSubscription;
  StreamSubscription<GpsState> _positionSubscription;

  String get driverName => _globalInfo.driverInfo.name;

  String get token => _notificationCubit.fcmToken;

  void init() {
    lastPosition = _gpsCubit.lastPosition ?? DEFAULT_LAT_LNG_IF_NONE_GIVEN;
    _notificationSubscription = _notificationCubit.listen(_handleNotifications);
    _positionSubscription = _gpsCubit.listen(_handlePositionUpdate);
  }

  Future<void> fetchHosInfo() async {
    await _hosCubit.fetchHosInfo(driverId: _globalInfo.driverInfo.id);
  }

  Future<void> _handleNotifications(NotificationState state) async {
    if (state is NotificationReceive) {
      final notification = state.notification;
      if (notification.action == NotificationAction.ROUTE_PROJECTED_UPDATE ||
          (notification.action == NotificationAction.ROUTE_PLANNED_UPDATE &&
              !route.isUsingPro)) {
        await _handleRouteSyncByNotification(notification);
      }
    }
  }

  Future<void> _handleRouteSyncByNotification(
      NotificationDto notification) async {
    try {
      final syncRoute = await _repository.syncRouteByNotification(route.id);
      route = mergeRoutes(route, syncRoute);
      emit(
        RouteUpdateDueNotificationSuccess(
          notificationId: notification.id,
          notificationAction: notification.action,
        ),
      );
    } on Exception {
      emit(
        RouteUpdateDueNotificationFailure(
          notificationId: notification.id,
          notificationAction: notification.action,
        ),
      );
    }
  }

  Future<void> _handlePositionUpdate(GpsState state) async {
    if (state is GpsNewPosition) {
      lastPosition = state.position;
      emit(RouteDriverPositionUpdate(lastPosition));
    }
  }

  Future<void> startRoute() async {
    try {
      emit(RouteStartLoad());
      await _repository.startRoute(route.id);
      route = route.copyWith(status: RouteStatus.STARTED);

      final proConfig = await _repository.fetchProConfig(route.id);
      if (proConfig != null) {
        route = route.copyWith(proactiveRouteOptConfig: proConfig);
        emit(RouteProConfigApply(proConfig));
      }

      emit(RouteStartSuccess());
    } on StartRouteException catch (e) {
      emit(RouteStartFailed(e.errorMessage));
    }
  }

  Future<void> departOrigin() async {
    try {
      emit(RouteDepartOriginLoad());
      _repository.departOrigin(route.id);
      route = route.copyWith(status: RouteStatus.DEPARTED_ORIGIN);
      emit(RouteDepartOriginSuccess());
    } on Exception {
      emit(RouteDepartOriginFailure());
    }
  }

  Future<void> arriveStop({
    StopModel stop,
    String actualArrival,
  }) async {
    try {
      emit(RouteArriveStopLoad(stop));
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
      final _updatedStop = stop.copyWith(actualArrival: actualArrival);
      route = updateRouteByStopChange(route, _updatedStop);
      emit(RouteArriveStopSuccess(_updatedStop));
    } on ArriveStopException catch (e) {
      emit(RouteArriveStopFailure(e.errorMessage));
    }
  }

  void updateRouteDueStopChange(StopModel stop) {
    route = updateRouteByStopChange(route, stop);
    emit(RouteUpdateDueStopChange(stop));
    if (!hasPendingStops(route)) {
      emit(RouteHasNoPendingStops());
    }
  }

  void updateRouteDueClonedStop(StopModel clonedStop) {
    route = updateRouteByAddStop(route, clonedStop);
    emit(RouteUpdateDueStopClone(clonedStop));
  }

  void updateRouteDueRedeliverStop(StopModel newStop) {
    route = updateRouteByAddStop(route, newStop);
    emit(RouteUpdateDueStopRedeliver(newStop));
  }

  Future<void> arriveWarehouse() async {
    try {
      emit(RouteArriveWarehouseLoad());
      await _repository.arriveWarehouse(route.id);
      emit(RouteArriveWarehouseSuccess());
    } on Exception {
      emit(RouteArriveWarehouseFailure());
    }
  }

  Future<void> completeRoute() async {
    try {
      emit(RouteCompleteLoad());
      await _repository.completeRoute(route.id);
      route = route.copyWith(status: RouteStatus.COMPLETED);
      emit(RouteCompleteSuccess());
    } on Exception {
      emit(RouteCompleteFailure());
    }
  }

  Future<void> launchMapForDirections({
    double latitude = 0.0,
    double longitude = 0.0,
  }) async {
    try {
      await _launchService.launchMap(
        latitude: latitude,
        longitude: longitude,
      );
    } on LaunchActionException catch (e) {
      emit(RouteLaunchMapForDirectionsFailure(e.errorMessage));
    }
  }

  @override
  Future<void> close() {
    _notificationSubscription?.cancel();
    _positionSubscription?.cancel();
    return super.close();
  }
}
