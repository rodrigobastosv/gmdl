import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../hive/boxes.dart';
import '../../repository/initial_setup_repository.dart';

part 'initial_settings_state.dart';

class InitialSettingsCubit extends Cubit<InitialSettingsState> {
  InitialSettingsCubit({
    this.repository,
    this.securityBox,
  }) : super(ServerValidationInitial());

  final InitialSetupRepository repository;
  final Box securityBox;

  Future<void> validateServerName(String serverName) async {
    try {
      final serverValidated = await repository.validateServerName(serverName);
      if (serverValidated) {
        securityBox.put(SERVER_NAME, serverName);
        emit(ServerValidationSuccess());
      } else {
        emit(ServerValidationFailed());
      }
    } on Exception {
      emit(ServerValidationFailed());
    }
  }
}
