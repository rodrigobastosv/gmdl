import 'package:flutter/material.dart';

import '../entity/dto/dtos.dart';
import '../entity/model/models.dart';

class GlobalInfo {
  DriverInfoDto driverInfo;
  MobileDeviceDto mobileDevice;
  GlobalConfigurationsDto globalConfigurations;
  Map<String, dynamic> userConfigurations;
  List<FeatureStateModel> featureStates;
  List<CancelCodeModel> cancelCodes;
  List<UndeliverableCodeModel> undeliverableCodes;

  void storeGeneralInfo({
    @required DriverInfoDto driverInfo,
    @required MobileDeviceDto mobileDevice,
    @required GlobalConfigurationsDto globalConfigurations,
    @required Map<String, dynamic> userConfigurations,
    @required List<CancelCodeModel> cancelCodes,
    @required List<UndeliverableCodeModel> undeliverableCodes,
  }) {
    this.driverInfo = driverInfo;
    this.mobileDevice = mobileDevice;
    this.globalConfigurations = globalConfigurations;
    this.userConfigurations = userConfigurations;
    this.cancelCodes = cancelCodes;
    this.undeliverableCodes = undeliverableCodes;
  }
}
