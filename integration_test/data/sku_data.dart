import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../main_test.dart';

Future<Map<String, dynamic>> createSkuType({
  Map<String, dynamic> skuType,
  Map<String, dynamic> organization,
}) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  final response = await client.post(
    '/SkuType',
    data: {
      'key': '1',
      'description': '1',
      'organization': {
        'id': organization['id'],
      },
    },
  );
  return response.data;
}

Future<void> deleteSkuType() async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  await client.post(
    '/SkuType/BatchDelete',
    data: [],
  );
}

Future<Map<String, dynamic>> createSku({
  Map<String, dynamic> organization,
  Map<String, dynamic> sku,
}) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  final response = await client.post(
    '/Sku',
    data: {
      'key': sku['key'],
      'description': sku['description'],
      'enabled': true,
      'organization': {
        'key': organization['key'],
      },
      ...sku
    },
  );
  return response.data;
}

Future<void> deleteSku() async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  await client.post(
    '/Sku/BatchDelete',
    data: [],
  );
}
