import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/repositories.dart';

part 'choose_equipment_state.dart';

class ChooseEquipmentCubit extends Cubit<ChooseEquipmentState> {
  ChooseEquipmentCubit(this._repository)
      : assert(_repository != null),
        super(ChooseEquipmentInitial());

  final EquipmentRepository _repository;

  Future<void> getEquipmentInfo(String equipmentKey) async {
    try {
      emit(LoadingEquipment());
      final equipmentWasFound = await _repository.getEquipment(equipmentKey);
      if (equipmentWasFound) {
        emit(EquipmentFound());
      } else {
        emit(EquipmentNotFound());
      }
    } on Exception {
      emit(EquipmentFailed());
    }
  }
}
