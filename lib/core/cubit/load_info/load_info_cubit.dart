import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../hive/boxes.dart';
import '../../repository/repositories.dart';

part 'load_info_state.dart';

class LoadInfoCubit extends Cubit<LoadInfoState> {
  LoadInfoCubit({
    @required this.repository,
    @required this.driverBox,
    @required this.globalConfigurationsBox,
    @required this.userConfigurationsBox,
  }) : super(LoadingInitial());

  final LoadingInfoRepository repository;
  final Box driverBox;
  final Box globalConfigurationsBox;
  final Box userConfigurationsBox;

  Future<void> getDriverInfo(String username) async {
    emit(InfoLoading('Loading Basic User Infos'));
    try {
      final driverInfo = await repository.getBasicDriverInfo(
        username: username,
      );
      driverBox.put(DRIVER_INFO, driverInfo);
      emit(BasicDriverInfoSuccess());

      emit(InfoLoading('Loading Global Configurations'));
      final globalConfigurations = await repository.getGlobalConfigurations();
      globalConfigurationsBox.put(
          GLOBAL_CONFIGURATIONS_BOX, globalConfigurations);
      emit(FetchGlobalConfigSuccess());

      emit(InfoLoading('Loading User Configurations'));
      final userConfigurations = await repository.getUserConfigurations();
      userConfigurationsBox.put(USER_CONFIGURATIONS_BOX, userConfigurations);
      emit(FetchUserConfigSuccess());

      emit(AllInfoLoadedSuccess());
    } on Exception {
      emit(DriverInfoFailed());
    }
  }
}
