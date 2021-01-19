import 'package:flutter/material.dart';

import '../entity/dto/dtos.dart';
import '../entity/model/models.dart';

class Store extends ChangeNotifier {
  String serverName;
  String sessionId;
  DriverInfoDto driverInfo;
  GlobalConfigurationsDto globalConfigurations;
  Map<String, dynamic> userConfigurations;
  List<FeatureStateModel> featureStates;
  List<CancelCodeModel> cancelCodes;
  List<UndeliverableCodeModel> undeliverableCodes;

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
    @required List<UndeliverableCodeModel> undeliverableCodes,
  }) {
    this.driverInfo = driverInfo;
    this.globalConfigurations = globalConfigurations;
    this.userConfigurations = userConfigurations;
    this.cancelCodes = cancelCodes;
    this.undeliverableCodes = undeliverableCodes;
    notifyListeners();
  }
}
