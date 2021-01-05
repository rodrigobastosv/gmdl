import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../hive/boxes.dart';
import '../../repository/repositories.dart';
import 'package:hive/hive.dart';

part 'loading_info_state.dart';

class LoadingInfoCubit extends Cubit<LoadingInfoState> {
  LoadingInfoCubit({
    @required this.repository,
    @required this.driverBox,
    @required this.configurationsBox,
  }) : super(LoadingInitial());

  final LoadingInfoRepository repository;
  final Box driverBox;
  final Box configurationsBox;

  Future<void> getDriverInfo(String username) async {
    emit(InfoLoading('Loading Basic User Infos'));
    try {
      final driverInfo = await repository.getBasicDriverInfo(
        username: username,
      );
      driverBox.put(DRIVER_INFO, driverInfo);
      emit(BasicDriverInfoSuccess());

      emit(InfoLoading('Loading Configs'));
      final configurations = await repository.getGlobalConfigurations();
      configurationsBox.put(CONFIGURATIONS_BOX, configurations);
      emit(FetchGlobalConfigSuccess());

    } on Exception {
      emit(DriverInfoFailed());
    }
  }
}
