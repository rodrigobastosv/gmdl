import 'package:flutter/foundation.dart';

enum HosEventType {
  ON_DUTY,
  OFF_DUTY,
  BREAK_START,
  BREAK_END,
  LUNCH_START,
  LUNCH_END,
  WAIT_START,
  WAIT_END,
  DRIVING_START,
  DRIVING_END
}

String hosEventTypeToJson(HosEventType type) => describeEnum(type);

HosEventType hosEventTypeFromJson(String type) {
  switch (type) {
    case 'ON_DUTY':
      return HosEventType.ON_DUTY;
    case 'OFF_DUTY':
      return HosEventType.OFF_DUTY;
    case 'BREAK_START':
      return HosEventType.BREAK_START;
    case 'BREAK_END':
      return HosEventType.BREAK_END;
    case 'LUNCH_START':
      return HosEventType.LUNCH_START;
    case 'LUNCH_END':
      return HosEventType.LUNCH_END;
    case 'WAIT_START':
      return HosEventType.WAIT_START;
    case 'WAIT_END':
      return HosEventType.WAIT_END;
    case 'DRIVING_START':
      return HosEventType.DRIVING_START;
    case 'DRIVING_END':
      return HosEventType.DRIVING_END;
  }
  return null;
}
