part of 'route_at_glance_cubit.dart';

abstract class RouteAtGlanceState extends Equatable {
  const RouteAtGlanceState();

  @override
  List<Object> get props => [];
}

class RouteAtGlanceInitial extends RouteAtGlanceState {}

class RouteLoadedSuccess extends RouteAtGlanceState {
  RouteLoadedSuccess(this.route);

  final RouteModel route;

  @override
  List<Object> get props => [route];
}

class RouteLoadFailed extends RouteAtGlanceState {}

class LoadingInfo extends RouteAtGlanceState {
  const LoadingInfo(this.info);

  final String info;

  @override
  List<Object> get props => [info];
}

class RouteAtGlanceLoadedSuccess extends RouteAtGlanceState {}

class RouteAtGlanceLoadingFailed extends RouteAtGlanceState {}
