import 'package:flutter/foundation.dart';

import '../locator.dart';

class GlobalInfoProvider extends ChangeNotifier {
  bool isServerValidated = false;
  bool isUserSignedIn = false;
  String username;
  String serverName;
  String sessionId;

  void changeServerName(String server) {
    isServerValidated = true;
    serverName = server;
    initLocator(serverName);
    notifyListeners();
  }

  void storeSignedUserInfo(String user, String id) {
    isUserSignedIn = true;
    username = user;
    sessionId = id;
    notifyListeners();
  }
}
