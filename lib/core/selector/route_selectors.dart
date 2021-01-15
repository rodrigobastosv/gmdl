import '../entity/model/models.dart';
import '../entity/model/route_model.dart';
import '../utils/utils.dart';

List<StopModel> getPendingStops(RouteModel route) {
  final routeStops = route.stops;
  return routeStops.where(isPendingStop).toList();
}

List<StopModel> getDoneStops(RouteModel route) {
  final routeStops = route.stops;
  return routeStops.where(isDoneStop).toList();
}

bool hasPendingStops(RouteModel route) {
  final routeStops = route.stops;
  return routeStops.any(isPendingStop);
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