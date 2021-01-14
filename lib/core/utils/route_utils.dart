import '../entity/model/models.dart';

bool isPendingStop(StopModel stop) =>
    stop.actualDeparture == null && !stop.canceled;

bool isDoneStop(StopModel stop) => !isPendingStop(stop);

RouteModel updateRouteByStopChange(RouteModel route, StopModel stop) {
  final stops = route.stops;
  final stopIndex = stops.indexWhere((it) => stop.id == it.id);
  stops[stopIndex] = stop;
  return route.copyWith(
    stops: stops,
  );
}

RouteModel updateRouteByAddStop(RouteModel route, StopModel stop) {
  final stops = route.stops;
  stops.add(stop);
  return route.copyWith(
    stops: [...stops],
  );
}
