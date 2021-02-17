import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/core/utils/utils.dart';

void main() {
  group('Time Utils', () {
    test(
      '''WHEN padDataField is called
         SHOULD return a data padded
      ''',
      () {
        expect(padDataField(1), '01');
        expect(padDataField(11), '11');
      },
    );

    test(
      '''WHEN getHourAndMinuteFromDateString is called
         SHOULD return date on the hh:mm format
      ''',
      () {
        final date = DateTime(2021, 12, 09, 10, 30).toIso8601String();
        expect(getHourAndMinuteFromDateString(date), '10:30');
      },
    );

    test(
      '''WHEN getHourAndMinuteFromSeconds is called
         SHOULD return date on the hh:mm format
      ''',
      () {
        expect(getHourAndMinuteFromSeconds(10), '00:10');
        expect(getHourAndMinuteFromSeconds(600), '10:00');
      },
    );

    test(
      '''WHEN getHourMinuteFromTimeOfDay is called
         SHOULD return date on the h:mm:00 format
      ''',
      () {
        expect(getHourMinuteFromTimeOfDay(null), null);
        expect(
          getHourMinuteFromTimeOfDay(
            const TimeOfDay(
              hour: 8,
              minute: 30,
            ),
          ),
          '8:30:00',
        );
      },
    );
  });
}
