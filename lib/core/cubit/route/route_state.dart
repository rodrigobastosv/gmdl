part of 'route_cubit.dart';

abstract class RouteState extends Equatable {
  const RouteState();

  @override
  List<Object> get props => [];
}

class RouteInitial extends RouteState {}

class RouteStartSuccess extends RouteState {}

class RouteStartFailed extends RouteState {
  RouteStartFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class RouteStartLoad extends RouteState {}

class RouteDepartOriginLoad extends RouteState {}

class RouteDepartOriginSuccess extends RouteState {}

class RouteDepartOriginFailure extends RouteState {}

class RouteArriveStopLoad extends RouteState {
  RouteArriveStopLoad(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class RouteArriveStopSuccess extends RouteState {
  RouteArriveStopSuccess(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class RouteArriveStopFailure extends RouteState {
  RouteArriveStopFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class RouteUpdateDueStopChange extends RouteState {
  RouteUpdateDueStopChange(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
        stop.actualArrival,
        stop.actualDeparture,
      ];
}

class RouteUpdateDueStopClone extends RouteState {
  RouteUpdateDueStopClone(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class RouteUpdateDueStopRedeliver extends RouteState {
  RouteUpdateDueStopRedeliver(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class RouteResyncSuccess extends RouteState {
  RouteResyncSuccess({
    this.route,
    this.syncDate,
  });

  final RouteModel route;
  final DateTime syncDate;

  @override
  List<Object> get props => [
        route.id,
        syncDate.toString(),
      ];
}

class RouteHasNoPendingStops extends RouteState {}

class RouteArriveWarehouseLoad extends RouteState {}

class RouteArriveWarehouseSuccess extends RouteState {}

class RouteArriveWarehouseFailure extends RouteState {}

class RouteCompleteLoad extends RouteState {}

class RouteCompleteSuccess extends RouteState {}

class RouteCompleteFailure extends RouteState {}

class RouteProConfigApply extends RouteState {
  RouteProConfigApply(this.proConfig);

  final ProactiveRouteOptConfigModel proConfig;

  @override
  List<Object> get props => [
        proConfig.id,
      ];
}

class RouteUpdateDueNotificationSuccess extends RouteState {
  RouteUpdateDueNotificationSuccess({
    @required this.notificationId,
    @required this.notificationAction,
  });

  final String notificationId;
  final NotificationAction notificationAction;

  @override
  List<Object> get props => [
        notificationId,
        notificationAction,
      ];
}

class RouteUpdateDueNotificationFailure extends RouteState {
  RouteUpdateDueNotificationFailure({
    @required this.notificationId,
    @required this.notificationAction,
  });

  final String notificationId;
  final NotificationAction notificationAction;

  @override
  List<Object> get props => [
        notificationId,
        notificationAction,
      ];
}

class RouteLaunchMapForDirectionsFailure extends RouteState {
  RouteLaunchMapForDirectionsFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class RouteDriverPositionUpdate extends RouteState {
  RouteDriverPositionUpdate(this.position);

  final Position position;

  @override
  List<Object> get props => [
        position.latitude,
        position.longitude,
      ];
}

class RouteQueueEmpty extends RouteState {}

class RouteQueueNotEmpty extends RouteState {}
