import 'package:package_info/package_info.dart';

class PackageInfoService {
  PackageInfoService(this._packageInfo);

  final PackageInfo _packageInfo;

  String getVersion() {
    return _packageInfo.version;
  }
}
