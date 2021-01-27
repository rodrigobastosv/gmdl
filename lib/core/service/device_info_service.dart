import 'package:device_info/device_info.dart';

import '../utils/platform_utils.dart';

class DeviceInfoService {
  DeviceInfoService(this._deviceInfo);

  final DeviceInfoPlugin _deviceInfo;

  AndroidDeviceInfo _androidDeviceInfo;
  IosDeviceInfo _iosDeviceInfo;

  Future<void> init() async {
    if (isAndroid()) {
      _androidDeviceInfo = await _deviceInfo.androidInfo;
    } else {
      _iosDeviceInfo = await _deviceInfo.iosInfo;
    }
  }

  String getId() {
    if (isAndroid()) {
      return _androidDeviceInfo.androidId;
    }
    return _iosDeviceInfo.identifierForVendor;
  }

  String getModel() {
    if (isAndroid()) {
      return _androidDeviceInfo.model;
    }
    return _iosDeviceInfo.model;
  }
}
