import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../main_test.dart';

Future<Map<String, dynamic>> createOrganization() async {
  final client = getDefaultTestClient(SERVER, token);
  final response = await client.post(
    '/Organization',
    data: {
      'key': 'q',
      'description': 'q',
      'preferedLocale': {
        'id': 10001,
      },
      'unitSystem': 'METRIC',
      'timeZone': {
        'id': 10002,
      },
      'listenerOrganizations': [],
    },
  );
  return response.data;
}

Future<void> deleteOrganization() async {
  final client = getDefaultTestClient(SERVER, token);
  await client.post(
    '/Organization/BatchDelete',
    data: [
      organization['id'],
    ],
  );
}
