import 'package:flutter/foundation.dart';

enum DriverType {
  DEFAULT,
  HELPER,
}

String driverTypeToJson(DriverType type) => describeEnum(type);

DriverType driverTypeFromJson(String type) {
  switch (type) {
    case 'DEFAULT':
      return DriverType.DEFAULT;
    case 'HELPER':
      return DriverType.HELPER;
  }
  return DriverType.DEFAULT;
}
