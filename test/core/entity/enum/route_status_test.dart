import 'package:flutter_test/flutter_test.dart';
import 'package:gm_driver_lite/core/entity/enum/enums.dart';

void main() {
  group('RouteStatus', () {
    test('statusToJson', () {
      expect(statusToJson(RouteStatus.NOT_STARTED), 'NOT_STARTED');
      expect(statusToJson(RouteStatus.STARTED), 'STARTED');
      expect(statusToJson(RouteStatus.DEPARTED_ORIGIN), 'DEPARTED_ORIGIN');
      expect(statusToJson(RouteStatus.COMPLETED), 'COMPLETED');
    });

    test('statusFromJson', () {
      expect(statusFromJson('NOT_STARTED'), RouteStatus.NOT_STARTED);
      expect(statusFromJson('STARTED'), RouteStatus.STARTED);
      expect(statusFromJson('DEPARTED_ORIGIN'), RouteStatus.DEPARTED_ORIGIN);
      expect(statusFromJson('COMPLETED'), RouteStatus.COMPLETED);
    });
  });
}
