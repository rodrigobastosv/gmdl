import '../entity/model/models.dart';
import '../entity/model/route_model.dart';

List<StopModel> getPendingStops(RouteModel route) {
  final routeStops = route.stops;
  return routeStops.where((stop) => stop.isPending).toList();
}

List<StopModel> getDoneStops(RouteModel route) {
  final routeStops = route.stops;
  return routeStops.where((stop) => stop.isDone).toList();
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
  final plannedHours = (plannedDifferenceInMinutes / 60).round();
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
