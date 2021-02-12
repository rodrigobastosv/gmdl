part of 'load_route_cubit.dart';

abstract class LoadRouteState extends Equatable {
  const LoadRouteState();

  @override
  List<Object> get props => [];
}

class LoadRouteInitial extends LoadRouteState {}

class LoadRouteSuccess extends LoadRouteState {
  LoadRouteSuccess(this.route);

  final RouteModel route;

  @override
  List<Object> get props => [route];
}

class LoadRouteFailure extends LoadRouteState {
  LoadRouteFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}

class LoadRouteLoad extends LoadRouteState {
  const LoadRouteLoad(this.info);

  final String info;

  @override
  List<Object> get props => [info];
}
