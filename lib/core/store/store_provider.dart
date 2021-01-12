import 'package:flutter/material.dart';

import '../entity/dto/driver_info_dto.dart';
import '../entity/dto/global_configurations_dto.dart';
import '../entity/model/feature_state_model.dart';

class StoreProvider extends ChangeNotifier {
  String serverName;
  String sessionId;
  DriverInfoDto driverInfo;
  GlobalConfigurationsDto globalConfigurations;
  Map<String, dynamic> userConfigurations;
  List<FeatureStateModel> featureStates;

  void changeServerName(String serverName) {
    this.serverName = serverName;
    notifyListeners();
  }

  void storeSessionId(String sessionId) {
    this.sessionId = sessionId;
    notifyListeners();
  }

  void storeGeneralInfo({
    DriverInfoDto driverInfo,
    GlobalConfigurationsDto globalConfigurations,
    Map<String, dynamic> userConfigurations,
  }) {
    this.driverInfo = driverInfo;
    this.globalConfigurations = globalConfigurations;
    this.userConfigurations = userConfigurations;
    notifyListeners();
  }
}
