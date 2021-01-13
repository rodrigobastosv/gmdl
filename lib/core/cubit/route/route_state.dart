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

class RouteHasNoPendingStops extends RouteState {}

class ArrivingWarehouse extends RouteState {}

class ArrivedWarehouseSuccess extends RouteState {}

class ArrivedWarehouseFailed extends RouteState {}

class CompletingRoute extends RouteState {}

class RouteCompletedSuccess extends RouteState {}

class RouteCompletedFailed extends RouteState {}
