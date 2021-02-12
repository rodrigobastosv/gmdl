import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../main_test.dart';

Future<int> createSkuType() async {
  final client = getDefaultTestClient(SERVER, token);
  final response = await client.post(
    '/SkuType',
    data: {
      'key': '1',
      'description': '1',
      'organization': {
        'id': organizationId,
      },
    },
  );
  return response.data['id'];
}

Future<void> deleteSkuType() async {
  final client = getDefaultTestClient(SERVER, token);
  await client.post(
    '/SkuType/BatchDelete',
    data: [
      skuTypeId,
    ],
  );
}

Future<int> createSku() async {
  final client = getDefaultTestClient(SERVER, token);
  final response = await client.post(
    '/Sku',
    data: {
      'key': '1',
      'description': '1',
      'organization': {
        'id': organizationId,
      },
    },
  );
  return response.data['id'];
}

Future<void> deleteSku() async {
  final client = getDefaultTestClient(SERVER, token);
  await client.post(
    '/Sku/BatchDelete',
    data: [
      skuId,
    ],
  );
}