import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/core/utils/utils.dart';

void main() {
  group('Notification Utils', () {
    test(
      '''WHEN getActionFromNotification is called
         SHOULD return the action of the notification
      ''',
      () {
        final notification = {
          'action': 'ROUTE_PLANNED_UPDATE',
          'content': 'some random content',
        };
        final action = getActionFromNotification(notification);
        expect(action, 'ROUTE_PLANNED_UPDATE');
      },
    );
  });
}
