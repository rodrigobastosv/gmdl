import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../test/basic_test.dart';

Future<Map<String, dynamic>> createOrderClass({
  Map<String, dynamic> orderClass,
  Map<String, dynamic> organization,
}) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  final response = await client.post(
    '/OrderClass',
    data: {
      ...orderClass,
      'organization': {
        'key': organization['key'],
      }
    },
  );
  return response.data;
}

Future<void> deleteOrderClass() async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  await client.post(
    '/OrderClass/BatchDelete',
    data: [],
  );
}
