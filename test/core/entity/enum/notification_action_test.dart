import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/core/entity/enum/enums.dart';

void main() {
  group('NotificationAction', () {
    test('notificationActionToJson', () {
      expect(notificationActionToJson(NotificationAction.ADD_STOP), 'ADD_STOP');
      expect(notificationActionToJson(NotificationAction.UPDATE_STOP),
          'UPDATE_STOP');
      expect(
          notificationActionToJson(NotificationAction.ROUTE_PROJECTED_UPDATE),
          'ROUTE_PROJECTED_UPDATE');
      expect(notificationActionToJson(NotificationAction.ROUTE_PLANNED_UPDATE),
          'ROUTE_PLANNED_UPDATE');
      expect(notificationActionToJson(NotificationAction.DEPART_STOP),
          'DEPART_STOP');
      expect(notificationActionToJson(NotificationAction.CANCEL_STOP),
          'CANCEL_STOP');
      expect(notificationActionToJson(NotificationAction.RETURN_STOP),
          'RETURN_STOP');
      expect(notificationActionToJson(NotificationAction.REDELIVERY_STOP),
          'REDELIVERY_STOP');
      expect(notificationActionToJson(NotificationAction.DEPART_ROUTE),
          'DEPART_ROUTE');
      expect(
          notificationActionToJson(
              NotificationAction.ROUTE_RESEQUENCE_SIMULATED),
          'ROUTE_RESEQUENCE_SIMULATED');
      expect(
          notificationActionToJson(
              NotificationAction.CARGO_RECONCILIATION_CREATED),
          'CARGO_RECONCILIATION_CREATED');
    });

    test('notificationActionFromJson', () {
      expect(
          notificationActionFromJson('ADD_STOP'), NotificationAction.ADD_STOP);
      expect(notificationActionFromJson('REMOVE_STOP'),
          NotificationAction.REMOVE_STOP);
      expect(notificationActionFromJson('UPDATE_STOP'),
          NotificationAction.UPDATE_STOP);
      expect(notificationActionFromJson('ROUTE_PROJECTED_UPDATE'),
          NotificationAction.ROUTE_PROJECTED_UPDATE);
      expect(notificationActionFromJson('UPDATE'), NotificationAction.UPDATE);
      expect(notificationActionFromJson('ROUTE_PLANNED_UPDATE'),
          NotificationAction.ROUTE_PLANNED_UPDATE);
      expect(notificationActionFromJson('DEPART_STOP'),
          NotificationAction.DEPART_STOP);
      expect(notificationActionFromJson('CANCEL_STOP'),
          NotificationAction.CANCEL_STOP);
      expect(notificationActionFromJson('RETURN_STOP'),
          NotificationAction.RETURN_STOP);
      expect(notificationActionFromJson('REDELIVERY_STOP'),
          NotificationAction.REDELIVERY_STOP);
      expect(notificationActionFromJson('DEPART_ROUTE'),
          NotificationAction.DEPART_ROUTE);
      expect(notificationActionFromJson('ROUTE_RESEQUENCE_SIMULATED'),
          NotificationAction.ROUTE_RESEQUENCE_SIMULATED);
      expect(notificationActionFromJson('CARGO_RECONCILIATION_CREATED'),
          NotificationAction.CARGO_RECONCILIATION_CREATED);
      expect(notificationActionFromJson(''), null);
    });
  });
}
