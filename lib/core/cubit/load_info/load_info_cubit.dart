import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../constants.dart';
import '../../global/global_info.dart';
import '../../repository/repositories.dart';
import '../../service/services.dart';
import '../../utils/general/platform_utils.dart';
import '../cubits.dart';

part 'load_info_state.dart';

class LoadInfoCubit extends Cubit<LoadInfoState> {
  LoadInfoCubit({
    @required LoadingInfoRepository repository,
    @required this.globalInfo,
    @required I18nCubit i18nCubit,
    @required DeviceInfoService deviceInfoService,
    @required PackageInfoService packageInfoService,
  })  : assert(repository != null),
        assert(globalInfo != null),
        assert(i18nCubit != null),
        assert(deviceInfoService != null),
        assert(packageInfoService != null),
        _repository = repository,
        _i18nCubit = i18nCubit,
        _deviceInfoService = deviceInfoService,
        _packageInfoService = packageInfoService,
        super(LoadingInitial());

  final LoadingInfoRepository _repository;
  final GlobalInfo globalInfo;
  final I18nCubit _i18nCubit;
  final DeviceInfoService _deviceInfoService;
  final PackageInfoService _packageInfoService;

  Future<void> getDriverInfo(String username) async {
    try {
      emit(InfoLoading(_i18nCubit.getFormattedText('driver.loading.data')));
      final driverInfo = await _repository.getDriverInfo(username: username);
      emit(BasicDriverInfoSuccess());

      emit(InfoLoading(
          _i18nCubit.getFormattedText('push.registerDeviceOnServer')));
      final mobileDevice = await _repository.registerDevice(
        deviceModel: _deviceInfoService.getModel(),
        platform: getPlatform(),
        platformVersion: _packageInfoService.getVersion(),
        uniqueDeviceId: _deviceInfoService.getId(),
      );
      emit(RegisterDeviceSuccess(mobileDevice.id));

      emit(InfoLoading(_i18nCubit.getFormattedText('push.bindModule')));
      await _repository.bindModule(
        deviceId: mobileDevice.id,
        appVersion: _packageInfoService.getVersion(),
        moduleKey: moduleKey,
      );

      emit(InfoLoading(
          _i18nCubit.getFormattedText('push.registerDeviceOnServer')));
      _repository.logDevice(
        userId: driverInfo.id,
        deviceId: mobileDevice.id,
      );
      emit(RegisterDeviceSuccess(mobileDevice.id));

      emit(InfoLoading(_i18nCubit.getFormattedText('Locale.list')));
      await _i18nCubit.fetchResources();
      emit(FetchResourcesSuccess());

      emit(InfoLoading(
          _i18nCubit.getFormattedText('loading.downloading.configurations')));
      final globalConfigurations = await _repository.getGlobalConfigurations();
      emit(FetchGlobalConfigSuccess());

      final userConfigurations = await _repository.getUserConfigurations();
      emit(FetchUserConfigSuccess());

      emit(InfoLoading(
          _i18nCubit.getFormattedText('loading.downloading.reasonCodes')));
      final cancelCodes = await _repository.fetchCancelCodes();
      emit(FetchCancelCodesSuccess());

      final undeliverableCodes = await _repository.fetchUndeliverableCodes();
      emit(FetchUndeliverableCodesSuccess());

      globalInfo.storeGeneralInfo(
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
