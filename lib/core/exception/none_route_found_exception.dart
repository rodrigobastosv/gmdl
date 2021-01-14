import 'gm_base_exception.dart';

class NoneRouteFoundException implements GMBaseException {
  @override
  String get errorMessage => 'No route was found';
}