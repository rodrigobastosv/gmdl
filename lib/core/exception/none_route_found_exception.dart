import 'gm_base_exception.dart';

class NoneRouteFoundException implements GMBaseException {
  @override
  String get errorMessage => 'loader.routes.not.found';
}
