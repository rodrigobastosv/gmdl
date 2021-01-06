import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'choose_equipment_state.dart';

class ChooseEquipmentCubit extends Cubit<ChooseEquipmentState> {
  ChooseEquipmentCubit() : super(ChooseEquipmentInitial());
}
