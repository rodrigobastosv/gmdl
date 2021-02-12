import 'package:gm_driver_lite/core/repository/client/client.dart';

Future<String> authAdmin() async {
  final client = getBasicTestClient();
  final response = await client.post(
    'https://textfile.greenmile.com/$SIGN_IN',
    queryParameters: {
      J_USERNAME: 'gmtmproot',
      J_PASSWORD: 'DrVMvXea~b^!8h8Y',
    },
  );
  return response.data['jsessionid'];
}
