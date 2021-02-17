import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../test/basic_test.dart';

Future<Map<String, dynamic>> createReasonCode({
  Map<String, dynamic> reasonCode,
  Map<String, dynamic> organization,
}) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  final response = await client.post(
    '/ReasonCode',
    data: {
      'organization': {
        'id': organization['id'],
      },
      'enabled': true,
      ...reasonCode
    },
  );
  return response.data;
}

Future<void> deleteReasonCode(int reasonCodeId) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  await client.post(
    '/ReasonCode/BatchDelete',
    data: [
    ],
  );
}
