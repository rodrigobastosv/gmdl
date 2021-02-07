part of 'route_cubit.dart';

abstract class RouteState extends Equatable {
  const RouteState();

  @override
  List<Object> get props => [];
}

class RouteInitial extends RouteState {}

class RouteStartedSuccess extends RouteState {}

class RouteStartFailed extends RouteState {
  RouteStartFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class StartingRoute extends RouteState {}

class DepartingOrigin extends RouteState {}

class DepartOriginSuccess extends RouteState {}

class DepartOriginFailed extends RouteState {}

class ArrivingStop extends RouteState {
  ArrivingStop(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class ArrivedStopSuccess extends RouteState {
  ArrivedStopSuccess(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class ArrivedStopFailed extends RouteState {
  ArrivedStopFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class RouteUpdatedDueStopChange extends RouteState {
  RouteUpdatedDueStopChange(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
        stop.actualArrival,
        stop.actualDeparture,
      ];
}

class RouteUpdatedDueStopClone extends RouteState {
  RouteUpdatedDueStopClone(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class RouteUpdatedDueStopRedeliver extends RouteState {
  RouteUpdatedDueStopRedeliver(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class RouteHasNoPendingStops extends RouteState {}

class ArrivingWarehouse extends RouteState {}

class ArrivedWarehouseSuccess extends RouteState {}

class ArrivedWarehouseFailed extends RouteState {}

class CompletingRoute extends RouteState {}

class RouteCompletedSuccess extends RouteState {}

class RouteCompletedFailed extends RouteState {}

class ProConfigAppliedToRoute extends RouteState {
  ProConfigAppliedToRoute(this.proConfig);

  final ProactiveRouteOptConfigModel proConfig;

  @override
  List<Object> get props => [
        proConfig.id,
      ];
}

class RouteUpdatedDueNotification extends RouteState {
  RouteUpdatedDueNotification({
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

class FailedToUpdatedRouteByNotification extends RouteState {
  FailedToUpdatedRouteByNotification({
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

class LaunchMapForDirectionsFailed extends RouteState {
  LaunchMapForDirectionsFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class DriverPositionUpdated extends RouteState {
  DriverPositionUpdated(this.position);

  final Position position;

  @override
  List<Object> get props => [
        position.latitude,
        position.longitude,
      ];
}

class ShowedStopOnMap extends RouteState {
  ShowedStopOnMap(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop,
      ];
}
