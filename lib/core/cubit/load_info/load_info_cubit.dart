import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/repositories.dart';
import '../../store/store_provider.dart';

part 'load_info_state.dart';

class LoadInfoCubit extends Cubit<LoadInfoState> {
  LoadInfoCubit({
    @required LoadingInfoRepository repository,
    @required this.storeProvider,
  })  : assert(repository != null),
        assert(storeProvider != null),
        _repository = repository,
        super(LoadingInitial());

  final LoadingInfoRepository _repository;
  final StoreProvider storeProvider;

  Future<void> getDriverInfo(String username) async {
    emit(InfoLoading('Loading Basic User Infos'));
    try {
      final driverInfo = await _repository.getDriverInfo(username: username);
      emit(BasicDriverInfoSuccess());

      emit(InfoLoading('Loading Global Configurations'));
      final globalConfigurations = await _repository.getGlobalConfigurations();
      emit(FetchGlobalConfigSuccess());

      emit(InfoLoading('Loading User Configurations'));
      final userConfigurations = await _repository.getUserConfigurations();
      emit(FetchUserConfigSuccess());

      storeProvider.storeGeneralInfo(
        driverInfo: driverInfo,
        globalConfigurations: globalConfigurations,
        userConfigurations: userConfigurations,
      );
      emit(AllInfoLoadedSuccess());
    } on Exception {
      emit(DriverInfoFailed());
    }
  }
}
