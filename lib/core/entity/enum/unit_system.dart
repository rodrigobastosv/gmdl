import 'package:flutter/foundation.dart';

enum UnitSystem {
  METRIC,
  NON_METRIC,
}

String unitSystemToJson(UnitSystem unit) => describeEnum(unit);

UnitSystem unitSystemFromJson(String unit) {
  switch (unit) {
    case 'METRIC':
      return UnitSystem.METRIC;
    case 'NON_METRIC':
      return UnitSystem.NON_METRIC;
  }
  return UnitSystem.NON_METRIC;
}
