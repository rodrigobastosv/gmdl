import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../test/basic_test.dart';

Future<Map<String, dynamic>> createOrganization({
  Map<String, dynamic> organization,
}) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
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

Future<void> deleteOrganization(int organizationId) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  await client.post(
    '/Organization/BatchDelete',
    data: [
      organizationId,
    ],
  );
}
