import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../entity/model/locale_model.dart';
import '../../entity/model/models.dart';
import '../../global/hive.dart';
import '../../i18n/local_resources.dart';
import '../../repository/repositories.dart';

part 'i18n_state.dart';

class I18nCubit extends Cubit<I18nState> {
  I18nCubit({
    @required I18nRepository repository,
    @required Box globalBox,
  })  : assert(repository != null),
        assert(globalBox != null),
        _repository = repository,
        _globalBox = globalBox,
        super(I18nInitial());

  final I18nRepository _repository;
  final Box _globalBox;

  String localeKey;
  Map<String, String> _resources;
  List<LocaleModel> _allLocales;

  void initI18nInfo() {
    _allLocales = _getLocales();
    localeKey = _globalBox.get(LOCALE_KEY) ?? 'en';
    _resources = localResources[localeKey];
  }

  List<LocaleModel> getAllLocales() => _allLocales;

  List<LocaleModel> _getLocales() {
    final _locales = _globalBox.get(ALL_LOCALES) ?? '';
    if (_locales.isNotEmpty) {
      final _localesDecoded = jsonDecode(_locales);
      if (_localesDecoded.isNotEmpty) {
        return List.generate(_localesDecoded.length,
            (i) => LocaleModel.fromJson(_localesDecoded[i]));
      }
    }
    return [];
  }

  void changeLocale(String localeKey) {
    this.localeKey = localeKey;
    _resources = localResources[localeKey];
    emit(I18nLocaleChange(localeKey));
  }

  Future<void> fetchResources() async {
    try {
      final _resourcesList = await _repository.fetchResources(localeKey);
      _resources.addAll(_getResourcesMap(_resourcesList));
      emit(I18nResourcesFetchSuccess());
    } on Exception {
      emit(I18nResourcesFetchFailure());
    }
  }

  Map<String, String> _getResourcesMap(List<ResourceModel> resources) {
    return {for (var resource in resources) resource.key: resource.value};
  }

  String getFormattedText(String id) {
    if (_resources.containsKey(id)) {
      return _resources[id];
    }
    return id;
  }
}
