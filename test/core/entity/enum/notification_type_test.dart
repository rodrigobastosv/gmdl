import 'package:flutter_test/flutter_test.dart';
import 'package:gm_driver_lite/core/entity/enum/enums.dart';

void main() {
  group('NotificationType', () {
    test('notificationTypeToJson', () {
      expect(notificationTypeToJson(NotificationType.ROUTE), 'ROUTE');
      expect(notificationTypeToJson(NotificationType.STOP), 'STOP');
      expect(notificationTypeToJson(NotificationType.ORDER), 'ORDER');
      expect(notificationTypeToJson(NotificationType.LINEITEM), 'LINEITEM');
      expect(notificationTypeToJson(NotificationType.START_CHAT), 'START_CHAT');
      expect(notificationTypeToJson(NotificationType.ETA), 'ETA');
      expect(notificationTypeToJson(NotificationType.SUGGESTED_CUSTOMER),
          'SUGGESTED_CUSTOMER');
      expect(notificationTypeToJson(NotificationType.DRIVER), 'DRIVER');
      expect(notificationTypeToJson(NotificationType.CHAT), 'CHAT');
      expect(notificationTypeToJson(NotificationType.UNKNOWN_TYPE),
          'UNKNOWN_TYPE');
      expect(notificationTypeToJson(NotificationType.APPROVAL_REQUEST),
          'APPROVAL_REQUEST');
      expect(notificationTypeToJson(NotificationType.EVENT), 'EVENT');
      expect(notificationTypeToJson(NotificationType.CARGO_RECONCILIATION),
          'CARGO_RECONCILIATION');
    });

    test('notificationTypeFromJson', () {
      expect(notificationTypeFromJson('ROUTE'), NotificationType.ROUTE);
      expect(notificationTypeFromJson('STOP'), NotificationType.STOP);
      expect(notificationTypeFromJson('ORDER'), NotificationType.ORDER);
      expect(notificationTypeFromJson('LINEITEM'), NotificationType.LINEITEM);
      expect(
          notificationTypeFromJson('START_CHAT'), NotificationType.START_CHAT);
      expect(notificationTypeFromJson('ETA'), NotificationType.ETA);
      expect(notificationTypeFromJson('SUGGESTED_CUSTOMER'),
          NotificationType.SUGGESTED_CUSTOMER);
      expect(notificationTypeFromJson('DRIVER'), NotificationType.DRIVER);
      expect(notificationTypeFromJson('CHAT'), NotificationType.CHAT);
      expect(notificationTypeFromJson('UNKNOWN_TYPE'),
          NotificationType.UNKNOWN_TYPE);
      expect(notificationTypeFromJson('APPROVAL_REQUEST'),
          NotificationType.APPROVAL_REQUEST);
      expect(notificationTypeFromJson('EVENT'), NotificationType.EVENT);
      expect(notificationTypeFromJson('CARGO_RECONCILIATION'),
          NotificationType.CARGO_RECONCILIATION);
    });
  });
}
