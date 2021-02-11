import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../exception/exceptions.dart';
import '../../repository/repositories.dart';

part 'choose_equipment_state.dart';

class ChooseEquipmentCubit extends Cubit<ChooseEquipmentState> {
  ChooseEquipmentCubit(this._repository)
      : assert(_repository != null),
        super(ChooseEquipmentInitial());

  final EquipmentRepository _repository;

  Future<void> getEquipmentInfo(String equipmentKey) async {
    try {
      emit(ChooseEquipmentLoad());
      await _repository.getEquipment(equipmentKey);
      emit(ChooseEquipmentFound());
    } on EquipmentNotFoundException catch (e) {
      emit(ChooseEquipmentNotFound(e.errorMessage));
    } on GMServerException catch (e) {
      emit(ChooseEquipmentFailure(e.errorMessage));
    }
  }
}
