import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../main_test.dart';

Future<Map<String, dynamic>> createDriver() async {
  final client = getDefaultTestClient(SERVER, token);
  final response = await client.post(
    '/Driver/Save',
    data: {
      'key': 'qqq',
      'name': 'qqq',
      'login': 'qqq',
      'organization': {
        'id': organization['id'],
      },
      'driverType': 'DEFAULT',
      'enabled': true,
      'password': '123',
      'preferedLocale': {
        'id': 10001,
      },
      'unitSystem': 'METRIC',
      'smartTrack': false,
      'organizations': []
    },
  );
  return response.data;
}

Future<void> deleteDriver() async {
  final client = getDefaultTestClient(SERVER, token);
  await client.post(
    '/Driver/BatchDelete',
    data: [
      driver['id'],
    ],
  );
}
