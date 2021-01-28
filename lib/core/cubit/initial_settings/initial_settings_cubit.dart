import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../exception/exceptions.dart';
import '../../global/hive.dart';
import '../../repository/initial_settings_repository.dart';

part 'initial_settings_state.dart';

class InitialSettingsCubit extends Cubit<InitialSettingsState> {
  InitialSettingsCubit({
    @required InitialSettingsRepository repository,
    @required this.globalBox,
  })  : assert(repository != null),
        assert(globalBox != null),
        _repository = repository,
        super(ServerValidationInitial());

  final InitialSettingsRepository _repository;
  final Box globalBox;

  Future<void> validateServerName(String serverName) async {
    try {
      emit(ValidatingServer());
      final locales = await _repository.fetchAllLocales(serverName);
      _repository.authIdpDiscovery(serverName);
      globalBox.put(SERVER, serverName);
      globalBox.put(ALL_LOCALES, jsonEncode(locales));
      emit(ServerValidationSuccess());
    } on GMServerException catch (e) {
      emit(ServerValidationFailed(e.errorMessage));
    }
  }
}
