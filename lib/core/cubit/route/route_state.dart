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
