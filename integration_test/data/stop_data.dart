import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../test/basic_test.dart';

Future<Map<String, dynamic>> createStopType({
  Map<String, dynamic> stopType,
  Map<String, dynamic> organization,
}) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  final response = await client.post(
    '/StopType',
    data: {
      'key': 'faker',
      'description': 'key',
      'organization': {
        'id': organization['id'],
      },
      'type': 'STOP',
      'locationRequired': false
    },
  );
  return response.data;
}

Future<void> deleteStopType(int stopTypeId) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  await client.post(
    '/StopType/BatchDelete',
    data: [],
  );
}
