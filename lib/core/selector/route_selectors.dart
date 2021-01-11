import '../entity/model/models.dart';
import '../entity/model/route_model.dart';
import '../utils/route_utils.dart';

List<StopModel> getPendingStops(RouteModel route) {
  final routeStops = route.stops;
  return routeStops.where(isPendingStop).toList();
}

List<StopModel> getDoneStops(RouteModel route) {
  final routeStops = route.stops;
  return routeStops.where(isDoneStop).toList();
}