import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entity/model/models.dart';
import '../../i18n/local_resources.dart';
import '../../repository/repositories.dart';
import '../../store/store.dart';

part 'i18n_state.dart';

class I18nCubit extends Cubit<I18nState> {
  I18nCubit(this._repository) : super(I18nInitial());

  final I18nRepository _repository;

  String locale;
  Map<String, String> _resources;

  void initResources(Store _store) {
    locale = _store.locale;
    _resources = localResources[locale];
  }

  void changeLocale(String locale) {
    this.locale = locale;
    _resources = localResources[locale];
    emit(LocaleChanged(locale));
  }

  Future<void> fetchResources() async {
    try {
      final _resourcesList = await _repository.fetchResources(locale);
      _resources.addAll(_getResourcesMap(_resourcesList));
      emit(ResourcesFetchSuccess());
    } on Exception {
      emit(ResourcesFetchFailed());
      rethrow;
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