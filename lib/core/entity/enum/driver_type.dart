enum DriverType {
  DEFAULT,
  HELPER,
}

String driverTypeToJson(DriverType type) {
  switch (type) {
    case DriverType.DEFAULT:
      return 'DEFAULT';
    case DriverType.HELPER:
      return 'HELPER';
  }
  return 'DEFAULT';
}

DriverType driverTypeFromJson(String type) {
  switch (type) {
    case 'DEFAULT':
      return DriverType.DEFAULT;
    case 'HELPER':
      return DriverType.HELPER;
  }
  return DriverType.DEFAULT;
}
