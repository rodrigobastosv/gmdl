import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../hive/boxes.dart';
import '../../repository/initial_setup_repository.dart';

part 'initial_settings_state.dart';

class InitialSettingsCubit extends Cubit<InitialSettingsState> {
  InitialSettingsCubit({
    @required InitialSetupRepository repository,
    @required Box securityBox,
  })  : assert(repository != null),
        assert(securityBox != null),
        _repository = repository,
        _securityBox = securityBox,
        super(ServerValidationInitial());

  final InitialSetupRepository _repository;
  final Box _securityBox;

  Future<void> validateServerName(String serverName) async {
    try {
      final serverValidated = await _repository.validateServerName(serverName);
      if (serverValidated) {
        _securityBox.put(SERVER_NAME, serverName);
        emit(ServerValidationSuccess());
      } else {
        emit(ServerValidationFailed());
      }
    } on Exception {
      emit(ServerValidationFailed());
    }
  }
}
