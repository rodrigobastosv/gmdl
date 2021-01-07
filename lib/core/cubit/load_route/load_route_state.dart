part of 'load_route_cubit.dart';

abstract class LoadRouteState extends Equatable {
  const LoadRouteState();

  @override
  List<Object> get props => [];
}

class RouteAtGlanceInitial extends LoadRouteState {}

class RouteLoadedSuccess extends LoadRouteState {
  RouteLoadedSuccess(this.route);

  final RouteModel route;

  @override
  List<Object> get props => [route];
}

class RouteLoadFailed extends LoadRouteState {}

class LoadingInfo extends LoadRouteState {
  const LoadingInfo(this.info);

  final String info;

  @override
  List<Object> get props => [info];
}
