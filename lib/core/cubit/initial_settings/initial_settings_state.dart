part of 'initial_settings_cubit.dart';

abstract class InitialSettingsState extends Equatable {
  const InitialSettingsState();

  @override
  List<Object> get props => [];
}

class InitialSettingsInitial extends InitialSettingsState {}

class InitialSettingsValidateServerLoad extends InitialSettingsState {}

class InitialSettingsValidateServerSuccess extends InitialSettingsState {}

class InitialSettingsValidateServerFailure extends InitialSettingsState {
  InitialSettingsValidateServerFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}