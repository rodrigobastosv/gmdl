import 'package:flutter/foundation.dart';

enum NotificationType {
  ROUTE,
  STOP,
  ORDER,
  LINEITEM,
  START_CHAT,
  ETA,
  SUGGESTED_CUSTOMER,
  DRIVER,
  CHAT,
  APPROVAL_REQUEST,
  UNKNOWN_TYPE,
  EVENT,
  CARGO_RECONCILIATION
}

String notificationTypeToJson(NotificationType type) => describeEnum(type);

NotificationType notificationTypeFromJson(String type) {
  switch (type) {
    case 'ROUTE':
      return NotificationType.ROUTE;
    case 'STOP':
      return NotificationType.STOP;
    case 'ORDER':
      return NotificationType.ORDER;
    case 'LINEITEM':
      return NotificationType.LINEITEM;
    case 'START_CHAT':
      return NotificationType.START_CHAT;
    case 'ETA':
      return NotificationType.ETA;
    case 'SUGGESTED_CUSTOMER':
      return NotificationType.SUGGESTED_CUSTOMER;
    case 'DRIVER':
      return NotificationType.DRIVER;
    case 'CHAT':
      return NotificationType.CHAT;
    case 'APPROVAL_REQUEST':
      return NotificationType.APPROVAL_REQUEST;
    case 'UNKNOWN_TYPE':
      return NotificationType.UNKNOWN_TYPE;
    case 'EVENT':
      return NotificationType.EVENT;
    case 'CARGO_RECONCILIATION':
      return NotificationType.CARGO_RECONCILIATION;
  }
  return null;
}
