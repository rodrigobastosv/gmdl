import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../main_test.dart';

Future<Map<String, dynamic>> createHosType() async {
  final client = getDefaultTestClient(SERVER, token);
  final response = await client.post(
    '/HoursOfServiceType',
    data: {
      'organization': {
        'id': organization['id']
      },
      'description': '1',
      'allowBreakAppointment': false,
      'allowWaitAppointment': false,
      'allowLunchAppointment': false,
      'inferDriveTimeBasedRouteActions': false,
      'breakTimeThresholdMinutes': 0,
      'breakTimeDurationMinutes': 0,
      'forceBreakTime': false,
      'lunchTimeThresholdMinutes': 0,
      'lunchTimeDurationMinutes': 0,
      'forceLunchTime': false
    },
  );
  return response.data;
}

Future<void> deleteHosType() async {
  final client = getDefaultTestClient(SERVER, token);
  await client.post(
    '/HoursOfServiceType/BatchDelete',
    data: [
      hosType['id'],
    ],
  );
}
