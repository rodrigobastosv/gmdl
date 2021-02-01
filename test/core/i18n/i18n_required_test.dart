import 'package:flutter_test/flutter_test.dart';
import 'package:gm_driver_lite/core/i18n/i18n_required.dart';

void main() {
  group('I18n required', () {
    test('should have requiredLocales defined', () {
      expect(requiredLocales, isNotEmpty);
    });

    test('should have requiredKeys defined', () {
      expect(requiredKeys, isNotEmpty);
    });
  });
}
