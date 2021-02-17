import 'package:flutter/foundation.dart';

enum HosEventType {
  LUNCH_START,
  LUNCH_END,
}

String hosEventTypeToJson(HosEventType type) => describeEnum(type);
