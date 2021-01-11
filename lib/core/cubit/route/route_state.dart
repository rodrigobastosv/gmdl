part of 'route_cubit.dart';

abstract class RouteState extends Equatable {
  const RouteState();

  @override
  List<Object> get props => [];
}

class RouteInitial extends RouteState {}

class RouteStartedSuccess extends RouteState {}

class RouteStartFailed extends RouteState {}

class StartingRoute extends RouteState {}

class DepartingOrigin extends RouteState {}

class DepartOriginSuccess extends RouteState {}

class DepartOriginFailed extends RouteState {}

class ArrivingStop extends RouteState {}

class ArrivedStopSuccess extends RouteState {
  ArrivedStopSuccess(this.stop);

  final StopModel stop;

  @override
  List<Object> get props => [
        stop.id,
      ];
}

class ArrivedStopFailed extends RouteState {}

class RouteUpdatedDueDepartStop extends RouteState {
  RouteUpdatedDueDepartStop(this.departedStop);

  final StopModel departedStop;

  @override
  List<Object> get props => [
        departedStop.id,
      ];
}
