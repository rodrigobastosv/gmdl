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
    @required Box globalBox,
  })  : assert(repository != null),
        assert(globalBox != null),
        _repository = repository,
        _globalBox = globalBox,
        super(InitialSettingsInitial());

  final InitialSettingsRepository _repository;
  final Box _globalBox;

  Future<void> validateServerName(String serverName) async {
    try {
      emit(InitialSettingsValidateServerLoad());
      final locales = await _repository.fetchAllLocales(serverName);
      _repository.authIdpDiscovery(serverName);
      _globalBox.put(SERVER, serverName);
      _globalBox.put(ALL_LOCALES, jsonEncode(locales));
      emit(InitialSettingsValidateServerSuccess());
    } on GMServerException catch (e) {
      emit(InitialSettingsValidateServerFailure(e.errorMessage));
    }
  }
}
