import 'package:dio/dio.dart';
import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../test/basic_test.dart';
import 'utils.dart';

Future<Map<String, dynamic>> importRoute({
  Map<String, dynamic> route,
  Map<String, dynamic> organization,
}) async {
  try {
    final organizationKey = organization['key'];
    final body = {
      'route': addTimesToRoute(
        updateRouteOrganization(
          route: route,
          organizationKey: organizationKey,
        ),
      )
    };
    final client = getDefaultTestClient(TEST_SERVER, token);
    final response = await client.post(
      '/Integration/RouteDetailAndDependencies?returnIdOnly=false&geocodeLocations=false',
      data: body,
    );
    return response.data;
  } on DioError {
    rethrow;
  }
}

Future<void> deleteRoute() async {}
