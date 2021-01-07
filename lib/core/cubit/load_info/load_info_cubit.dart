import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../hive/boxes.dart';
import '../../repository/repositories.dart';

part 'load_info_state.dart';

class LoadInfoCubit extends Cubit<LoadInfoState> {
  LoadInfoCubit({
    @required LoadingInfoRepository repository,
    @required Box driverBox,
    @required Box globalConfigurationsBox,
    @required Box userConfigurationsBox,
  })  : assert(repository != null),
        assert(driverBox != null),
        assert(globalConfigurationsBox != null),
        assert(userConfigurationsBox != null),
        _repository = repository,
        _driverBox = driverBox,
        _globalConfigurationsBox = globalConfigurationsBox,
        _userConfigurationsBox = userConfigurationsBox,
        super(LoadingInitial());

  final LoadingInfoRepository _repository;
  final Box _driverBox;
  final Box _globalConfigurationsBox;
  final Box _userConfigurationsBox;

  Future<void> getDriverInfo(String username) async {
    emit(InfoLoading('Loading Basic User Infos'));
    try {
      final driverInfo = await _repository.getBasicDriverInfo(
        username: username,
      );
      _driverBox.put(DRIVER_INFO, driverInfo);
      emit(BasicDriverInfoSuccess());

      emit(InfoLoading('Loading Global Configurations'));
      final globalConfigurations = await _repository.getGlobalConfigurations();
      _globalConfigurationsBox.put(
          GLOBAL_CONFIGURATIONS_BOX, globalConfigurations);
      emit(FetchGlobalConfigSuccess());

      emit(InfoLoading('Loading User Configurations'));
      final userConfigurations = await _repository.getUserConfigurations();
      _userConfigurationsBox.put(USER_CONFIGURATIONS_BOX, userConfigurations);
      emit(FetchUserConfigSuccess());

      emit(AllInfoLoadedSuccess());
    } on Exception {
      emit(DriverInfoFailed());
    }
  }
}
