import 'gm_base_exception.dart';

class EquipmentNotFoundException implements GMBaseException {
  @override
  String get errorMessage => 'Equipment was not found';
}