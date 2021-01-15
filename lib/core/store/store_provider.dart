import 'package:flutter/material.dart';

import '../entity/dto/driver_info_dto.dart';
import '../entity/dto/global_configurations_dto.dart';
import '../entity/model/cancel_code_model.dart';
import '../entity/model/feature_state_model.dart';

class StoreProvider extends ChangeNotifier {
  String serverName;
  String sessionId;
  DriverInfoDto driverInfo;
  GlobalConfigurationsDto globalConfigurations;
  Map<String, dynamic> userConfigurations;
  List<FeatureStateModel> featureStates;
  List<CancelCodeModel> cancelCodes;

  void changeServerName(String serverName) {
    this.serverName = serverName;
    notifyListeners();
  }

  void storeSessionId(String sessionId) {
    this.sessionId = sessionId;
    notifyListeners();
  }

  void storeGeneralInfo({
    @required DriverInfoDto driverInfo,
    @required GlobalConfigurationsDto globalConfigurations,
    @required Map<String, dynamic> userConfigurations,
    @required List<CancelCodeModel> cancelCodes,
  }) {
    this.driverInfo = driverInfo;
    this.globalConfigurations = globalConfigurations;
    this.userConfigurations = userConfigurations;
    this.cancelCodes = cancelCodes;
    notifyListeners();
  }
}
