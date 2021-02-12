import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../main_test.dart';

Future<int> createEquipmentType() async {
  final client = getDefaultTestClient(SERVER, token);
  final response = await client.post(
    '/EquipmentType',
    data: {
      'key': '1',
      'description': '1',
      'vehicleType': 'TRUCK',
      'organization': {
        'id': organizationId,
      },
      'enabled': true,
      'height': '0',
      'weight': '0',
      'size1': '0',
      'size2': '0',
      'size3': '0',
      'fixedRouteCost': '0',
      'costPerMinute': '0',
      'minimumTimeMinutes': 0,
      'perDistanceRateKm': '0',
      'minimumDistance': 0,
      'perSize1Rate': '0',
      'minimumSize1': 0,
      'carbonFactor': '0',
      'averageFuelConsumption': '0',
    },
  );
  return response.data['id'];
}

Future<void> deleteEquipmentType() async {
  final client = getDefaultTestClient(SERVER, token);
  await client.post(
    '/EquipmentType/BatchDelete',
    data: [
      equipmentTypeId,
    ],
  );
}

Future<int> createEquipment() async {
  final client = getDefaultTestClient(SERVER, token);
  final response = await client.post(
    '/Equipment',
    data: {
      'key': '1',
      'organization': {
        'id': organizationId,
      },
      'description': '1',
      'enabled': true,
      'equipmentType': {
        'id': equipmentTypeId,
      },
      'tags': [],
    },
  );
  return response.data['id'];
}

Future<void> deleteEquipment() async {
  final client = getDefaultTestClient(SERVER, token);
  await client.post(
    '/Equipment/BatchDelete',
    data: [
      equipmentId,
    ],
  );
}