import 'package:flutter/foundation.dart';

import '../locator.dart';

class GlobalInfoProvider extends ChangeNotifier {
  bool isServerValidated = false;
  String serverName;

  void changeServerName(String server) {
    isServerValidated = true;
    serverName = server;
    initLocator(serverName);
    notifyListeners();
  }
}
