import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../test/basic_test.dart';

Future<Map<String, dynamic>> createLocation({
  Map<String, dynamic> location,
  Map<String, dynamic> organization,
}) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  final response = await client.post(
    '/Location',
    data: {
      'key': 'faker',
      'description': 'key',
      'organization': {
        'id': organization['id'],
      },
      'enabled': true,
      'locationType': <String, dynamic>{
        ...location['locationType'],
      },
      'geocodingQuality': 'MANUAL',
      'latitude': 'faker.address.latitude()',
      'longitude': 'faker.address.latitude()',
      'allowedUsers': []
    },
  );
  return response.data;
}

Future<void> deleteEquipmentType(int locationId) async {
  final client = getDefaultTestClient(TEST_SERVER, token);
  await client.post(
    '/Location/BatchDelete',
    data: [
      locationId,
    ],
  );
}
