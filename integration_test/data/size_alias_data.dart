import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../test/basic_test.dart';

Future<Map<String, dynamic>> createSizeAlias({
  Map<String, dynamic> sizeAlias,
}) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  final response = await client.post(
    '/SizeAlias',
    data: sizeAlias,
  );
  return response.data;
}

Future<void> deleteSizeAlias(Map<String, dynamic> sizeAlias) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  await client.post(
    '/SizeAlias/BatchDelete',
    data: [
    ],
  );
}
