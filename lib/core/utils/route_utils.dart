import '../entity/model/models.dart';
import '../selector/route_selectors.dart';

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

bool isStopNextSuggestion(RouteModel route, StopModel stop) {
  final pendingStops = getPendingStops(route);
  return stop == pendingStops[0];
}

RouteModel mergeRoutes(RouteModel originalRoute, RouteModel nextRoute) {
  return originalRoute.copyWith(
    organization: nextRoute.organization,
    date: nextRoute.date,
    description: nextRoute.description,
    origin: nextRoute.origin,
    destination: nextRoute.destination,
    stops: nextRoute.stops,
    plannedArrival: nextRoute.plannedArrival,
    plannedDeparture: nextRoute.plannedArrival,
    plannedDistance: nextRoute.plannedDistance,
    plannedComplete: nextRoute.plannedComplete,
    plannedStart: nextRoute.plannedStart,
    totalStops: nextRoute.totalStops,
    status: nextRoute.status,
    plannedServiceTime: nextRoute.plannedServiceTime,
    hasPicture: nextRoute.hasPicture,
    proactiveRouteOptConfig: nextRoute.proactiveRouteOptConfig,
    onRoute: nextRoute.onRoute,
    proactiveRouteOptApplied: nextRoute.proactiveRouteOptApplied,
  );
}
