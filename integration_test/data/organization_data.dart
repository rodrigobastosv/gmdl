import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../main_test.dart';

Future<Map<String, dynamic>> createOrganization({
  Map<String, dynamic> organization,
}) async {
  final client = getDefaultTestClient(SERVER, token);
  final response = await client.post(
    '/Organization',
    data: {
      'key': 'faker',
      'description': 'test',
      'preferedLocale': {
        'id': 10000,
      },
      'unitSystem': 'METRIC',
      'timeZone': {
        'id': 10002,
      },
      'listenerOrganizations': [],
      ...organization,
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
