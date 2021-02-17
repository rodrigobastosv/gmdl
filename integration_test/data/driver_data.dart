import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../test/basic_test.dart';

Future<Map<String, dynamic>> createDriver({
  Map<String, dynamic> driver,
  Map<String, dynamic> organization,
}) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  final response = await client.post(
    '/Driver/Save',
    data: {
      'enabled': true,
      'driverType': 'DEFAULT',
      'password': '123',
      'preferedLocale': {'id': 10000},
      'unitSystem': 'METRIC',
      'smartTrack': false,
      'organizations': [],
      'name': driver['key'],
      'login': driver['key'],
      ...driver,
      'organization': driver['organization'] ?? organization
    },
  );
  return response.data;
}

Future<void> deleteDriver() async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  await client.post(
    '/Driver/BatchDelete',
    data: [
    ],
  );
}
