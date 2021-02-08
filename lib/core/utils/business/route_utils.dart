import '../../entity/model/models.dart';

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

List<StopModel> getPendingStops(RouteModel route) {
  final routeStops = route.stops;
  return routeStops.where((stop) => stop.isPending).toList();
}

List<StopModel> getDoneStops(RouteModel route) {
  final routeStops = route.stops;
  return routeStops.where((stop) => stop.isDone).toList();
}

List<StopModel> getStopsOrderedByPlannedSequenceNum(List<StopModel> stops) {
  final stopsToOrder = [...stops];
  stopsToOrder.sort((s1, s2) => s1.plannedSequenceNum - s2.plannedSequenceNum);
  return stopsToOrder;
}

StopModel getNextSuggestedStop(RouteModel route) {
  final stopsOrderedBySequenceNum = [
    ...getStopsOrderedByPlannedSequenceNum(route.stops),
  ];
  return stopsOrderedBySequenceNum.first;
}

bool hasPendingStops(RouteModel route) {
  final routeStops = route.stops;
  return routeStops.any((stop) => stop.isPending);
}

double getPlannedDistanceInKm(RouteModel route) {
  final plannedDistance = route.plannedDistance;
  return plannedDistance / 1000;
}

String getPlannedServiceInHoursAndMinutes(RouteModel route) {
  final plannedDeparture = DateTime.parse(route.plannedDeparture);
  final plannedArrival = DateTime.parse(route.plannedArrival);
  final plannedDifferenceInMinutes =
      plannedArrival.difference(plannedDeparture).inMinutes;
  final plannedHours = (plannedDifferenceInMinutes / 60).floor();
  final plannedMinutes = (plannedDifferenceInMinutes % 60).round();
  return '${plannedHours}h ${plannedMinutes}m';
}

StopModel getLastStopOrderedById(RouteModel route) {
  final stops = [...route.stops];
  stops.sort((s1, s2) => s1.id.compareTo(s2.id));
  return stops.last;
}

StopModel getLastPlannedStop(RouteModel route) {
  final stops = [...route.stops];
  stops
      .sort((s1, s2) => s1.plannedSequenceNum.compareTo(s2.plannedSequenceNum));
  return stops.last;
}
