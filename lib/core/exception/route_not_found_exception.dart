import 'gm_base_exception.dart';

class RouteNotFoundException implements GMBaseException {
  RouteNotFoundException(this.routeId);

  final int routeId;
}
