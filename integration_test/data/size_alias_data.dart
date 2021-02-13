import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../main_test.dart';

Future<Map<String, dynamic>> createSizeAlias({
  Map<String, dynamic> sizeAlias,
}) async {
  final client = getDefaultTestClient(SERVER, token);
  final response = await client.post(
    '/SizeAlias',
    data: sizeAlias,
  );
  return response.data;
}

Future<void> deleteSizeAlias(Map<String, dynamic> sizeAlias) async {
  final client = getDefaultTestClient(SERVER, token);
  await client.post(
    '/SizeAlias/BatchDelete',
    data: [
      sizeAlias['id'],
    ],
  );
}
