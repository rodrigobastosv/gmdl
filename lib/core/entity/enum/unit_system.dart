enum UnitSystem {
  METRIC,
  NON_METRIC,
}

String unitSystemToJson(UnitSystem unit) {
  switch (unit) {
    case UnitSystem.METRIC:
      return 'METRIC';
    case UnitSystem.NON_METRIC:
      return 'NON_METRIC';
  }
  return 'METRIC';
}

UnitSystem unitSystemFromJson(String unit) {
  switch (unit) {
    case 'METRIC':
      return UnitSystem.METRIC;
    case 'NON_METRIC':
      return UnitSystem.NON_METRIC;
  }
  return UnitSystem.NON_METRIC;
}
