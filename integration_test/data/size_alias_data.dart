import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../main_test.dart';

Future<Map<String, dynamic>> createSizeAlias(String i) async {
  final client = getDefaultTestClient(SERVER, token);
  final response = await client.post(
    '/SizeAlias',
    data: {
      'key': i,
      'description': i,
      'preferredSize': i,
      'icon': 'gmfont-sizes-icon-size$i',
    },
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
