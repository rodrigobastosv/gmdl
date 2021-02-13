import 'package:gm_driver_lite/core/repository/client/client.dart';

import '../main_test.dart';

Future<String> authAdmin() async {
  final client = getBasicTestClient();
  final response = await client.post(
    'https://$TEST_SERVER.greenmile.com/$SIGN_IN',
    queryParameters: {
      J_USERNAME: 'gmtmproot',
      J_PASSWORD: 'o71C3*YG+!TQ616Z',
    },
  );
  return response.data['jsessionid'];
}
