import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/core/utils/utils.dart';

void main() {
  group('Date Utils', () {
    test(
      '''WHEN getBasicDateHourMinute is called
         SHOULD return date string in a basic hour and minute format
      ''',
      () {
        final date = DateTime(2021, 1, 1);
        expect(getBasicDateHourMinute(date.toIso8601String()), '12:00 AM');
      },
    );

    test(
      '''WHEN getBasicDateMonthDay is called
         SHOULD return date string with month and day
      ''',
      () {
        final date = DateTime(2021, 1, 1);
        expect(getBasicDateMonthDay(date.toIso8601String()), 'Jan 01');
      },
    );
  });
}
