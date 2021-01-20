import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:equatable/equatable.dart';

import '../../repository/repositories.dart';
import '../../store/store.dart';

part 'load_info_state.dart';

class LoadInfoCubit extends Cubit<LoadInfoState> {
  LoadInfoCubit({
    @required LoadingInfoRepository repository,
    @required this.store,
    @required DeviceInfoPlugin deviceInfo,
  })  : assert(repository != null),
        assert(store != null),
        assert(deviceInfo != null),
        _repository = repository,
        _deviceInfo = deviceInfo,
        super(LoadingInitial());

  final LoadingInfoRepository _repository;
  final Store store;
  final DeviceInfoPlugin _deviceInfo;

  Future<void> getDriverInfo(String username) async {
    try {
      emit(InfoLoading('Loading Basic User Information'));
      final driverInfo = await _repository.getDriverInfo(username: username);
      emit(BasicDriverInfoSuccess());

      emit(InfoLoading('Registering Device'));
      final androidInfo = await _deviceInfo.androidInfo;
      final mobileDevice = await _repository.registerDevice(
        deviceModel: androidInfo.model,
        platform: 'ANDROID',
        platformVersion: androidInfo.version.release,
        uniqueDeviceId: androidInfo.androidId,
      );
      emit(RegisterDeviceSuccess(mobileDevice.id));

      emit(InfoLoading('Binding Module'));
      await _repository.bindModule(
        deviceId: mobileDevice.id,
        appVersion: '1.0.0',
        moduleKey: 'GreenMileDriver7',
      );

      emit(InfoLoading('Logging Device'));
      _repository.logDevice(
        userId: driverInfo.id,
        deviceId: mobileDevice.id,
      );
      emit(RegisterDeviceSuccess(mobileDevice.id));

      emit(InfoLoading('Loading Global Configurations'));
      final globalConfigurations = await _repository.getGlobalConfigurations();
      emit(FetchGlobalConfigSuccess());

      emit(InfoLoading('Loading User Configurations'));
      final userConfigurations = await _repository.getUserConfigurations();
      emit(FetchUserConfigSuccess());

      emit(InfoLoading('Fetching Cancel Codes'));
      final cancelCodes = await _repository.fetchCancelCodes();
      emit(FetchCancelCodesSuccess());

      emit(InfoLoading('Fetching Undeliverable Codes'));
      final undeliverableCodes = await _repository.fetchUndeliverableCodes();
      emit(FetchUndeliverableCodesSuccess());

      store.storeGeneralInfo(
        driverInfo: driverInfo,
        mobileDevice: mobileDevice,
        globalConfigurations: globalConfigurations,
        userConfigurations: userConfigurations,
        cancelCodes: cancelCodes,
        undeliverableCodes: undeliverableCodes,
      );

      emit(AllInfoLoadedSuccess());
    } on Exception {
      emit(DriverInfoFailed());
    }
  }
}
