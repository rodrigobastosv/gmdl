part of 'route_at_glance_cubit.dart';

abstract class RouteAtGlanceState extends Equatable {
  const RouteAtGlanceState();

  @override
  List<Object> get props => [];
}

class RouteAtGlanceInitial extends RouteAtGlanceState {}

class LoadingInfo extends RouteAtGlanceState {
  const LoadingInfo(this.info);

  final String info;

  @override
  List<Object> get props => [info];
}

class RouteAtGlanceLoadedSuccess extends RouteAtGlanceState {}

class RouteAtGlanceLoadingFailed extends RouteAtGlanceState {}
