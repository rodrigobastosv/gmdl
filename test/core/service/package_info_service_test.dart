import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:gm_driver_lite/core/service/services.dart';
import '../../mocks.dart';

void main() {
  PackageInfoService packageInfoService;
  MockPackageInfo mockPackageInfo;

  group('PackageInfoService', () {
    setUp(() {
      mockPackageInfo = MockPackageInfo();
      packageInfoService = PackageInfoService(mockPackageInfo);
    });

    test('getVersion', () {
      when(mockPackageInfo.version).thenReturn('version');
      expect(packageInfoService.getVersion(), 'version');
    });
  });
}
