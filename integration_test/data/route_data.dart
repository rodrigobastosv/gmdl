import 'package:gm_driver_lite/core/repository/client/utils.dart';

import '../main_test.dart';
import 'utils.dart';

Future<Map<String, dynamic>> importRoute({
  Map<String, dynamic> route,
  Map<String, dynamic> organization,
}) async {
  final organizationKey = organization['key'];
  final body = {
    'route': addTimesToRoute(
      updateRouteOrganization(
        route: route,
        organizationKey: organizationKey,
      ),
    )
  };
  final client = getDefaultTestClient(SERVER, token);
  final response = await client.post(
    '/Integration/RouteDetailAndDependencies?returnIdOnly=false&geocodeLocations=false',
    data: body,
  );
  return response.data;
}

Future<void> deleteRoute() async {}
