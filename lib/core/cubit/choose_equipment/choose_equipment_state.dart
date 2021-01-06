part of 'choose_equipment_cubit.dart';

abstract class ChooseEquipmentState extends Equatable {
  const ChooseEquipmentState();

  @override
  List<Object> get props => [];
}

class ChooseEquipmentInitial extends ChooseEquipmentState {}

class EquipmentFound extends ChooseEquipmentState {}

class EquipmentNotFound extends ChooseEquipmentState {}

class EquipmentFailed extends ChooseEquipmentState {}

class LoadingEquipment extends ChooseEquipmentState {}
