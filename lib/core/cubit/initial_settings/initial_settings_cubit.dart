import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../repository/initial_setup_repository.dart';

part 'initial_settings_state.dart';

class InitialSettingsCubit extends Cubit<InitialSettingsState> {
  InitialSettingsCubit({
    @required InitialSetupRepository repository,
    @required this.store,
  })  : assert(repository != null),
        assert(store != null),
        _repository = repository,
        super(ServerValidationInitial());

  final InitialSetupRepository _repository;
  final Box store;

  Future<void> validateServerName(String serverName) async {
    try {
      emit(ValidatingServer());
      final serverValidated = await _repository.validateServerName(serverName);
      if (serverValidated) {
        store.put('serverName', serverName);
        emit(ServerValidationSuccess());
      } else {
        emit(
          ServerValidationFailed(
            'The $serverName server is unavailable or does not exist!',
          ),
        );
      }
    } on Exception {
      emit(
        ServerValidationFailed(
          'The $serverName server is unavailable or does not exist!',
        ),
      );
    }
  }
}
