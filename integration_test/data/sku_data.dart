import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../main_test.dart';

Future<Map<String, dynamic>> createSkuType({
  Map<String, dynamic> skuType,
}) async {
  final client = getDefaultTestClient(SERVER, token);
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
  final client = getDefaultTestClient(SERVER, token);
  await client.post(
    '/SkuType/BatchDelete',
    data: [
      skuType['id'],
    ],
  );
}

Future<Map<String, dynamic>> createSku({
  Map<String, dynamic> organization,
  Map<String, dynamic> sku,
}) async {
  final client = getDefaultTestClient(SERVER, token);
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
  final client = getDefaultTestClient(SERVER, token);
  await client.post(
    '/Sku/BatchDelete',
    data: [
      sku['id'],
    ],
  );
}
