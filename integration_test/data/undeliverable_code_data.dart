import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../test/basic_test.dart';

Future<Map<String, dynamic>> createUndeliverableCode({
  Map<String, dynamic> undeliverableCode,
  Map<String, dynamic> organization,
}) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  final response = await client.post(
    '/UndeliverableCode',
    data: {
      'organization': {
        'id': organization['id'],
      },
      'enabled': true,
      ...undeliverableCode
    },
  );
  return response.data;
}

Future<void> deleteUndeliverableCode(int undeliverableCodeId) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  await client.post(
    '/UndeliverableCode/BatchDelete',
    data: [
    ],
  );
}
