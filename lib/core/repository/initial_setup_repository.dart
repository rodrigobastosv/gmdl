import 'package:dio/dio.dart';

import '../constants.dart';
import 'client/client.dart';

class InitialSetupRepository {
  InitialSetupRepository(this.client);

  final Dio client;

  Future<bool> validateServerName(String serverName) async {
    try {
      final response = await client.get(
        'https://$serverName.greenmile.com/auth/idp/discovery',
        queryParameters: {
          CONSUMER: moduleName,
          SCOPE: moduleScope,
        },
      );
      return response.statusCode == 200;
    } on Exception {
      return false;
    }
  }
}
