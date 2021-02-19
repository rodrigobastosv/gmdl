import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../test/basic_test.dart';

Future<Map<String, dynamic>> createCancelCode({
  Map<String, dynamic> cancelCode,
  Map<String, dynamic> organization,
}) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  final response = await client.post(
    '/CancelCode',
    data: {
      'organization': {
        'key': organization['key'],
      },
      'enabled': true,
      ...cancelCode
    },
  );
  return response.data;
}

Future<void> deleteCancelCode() async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  await client.post(
    '/CancelCode/BatchDelete',
    data: [],
  );
}
