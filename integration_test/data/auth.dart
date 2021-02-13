import 'package:gm_driver_lite/core/global/hive.dart';
import 'package:gm_driver_lite/core/repository/client/client.dart';

Future<String> authAdmin() async {
  final client = getBasicTestClient();
  final response = await client.post(
    'https://$SERVER.greenmile.com/$SIGN_IN',
    queryParameters: {
      J_USERNAME: 'gmtmproot',
      J_PASSWORD: 'o71C3*YG+!TQ616Z',
    },
  );
  return response.data['jsessionid'];
}
