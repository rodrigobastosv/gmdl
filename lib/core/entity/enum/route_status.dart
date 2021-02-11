import 'package:flutter/foundation.dart';

enum RouteStatus {
  NOT_STARTED,
  STARTED,
  DEPARTED_ORIGIN,
  COMPLETED,
}

String statusToJson(RouteStatus status) => describeEnum(status);

RouteStatus statusFromJson(String status) {
  switch (status) {
    case 'NOT_STARTED':
      return RouteStatus.NOT_STARTED;
    case 'STARTED':
      return RouteStatus.STARTED;
    case 'DEPARTED_ORIGIN':
      return RouteStatus.DEPARTED_ORIGIN;
    case 'COMPLETED':
      return RouteStatus.COMPLETED;
  }
  return RouteStatus.NOT_STARTED;
}
