// Package imports:
import 'package:dio/dio.dart';

class InitialSetupRepository {
  InitialSetupRepository(this.client);

  final Dio client;

  Future<bool> validateServerName(String serverName) async {
    try {
      final response = await client.get(
        'https://$serverName.greenmile.com/auth/idp/discovery',
        queryParameters: {
          'consumer': 'DRIVER',
          'scope': 'driver7:default',
        },
      );
      return response.statusCode == 200;
    } on Exception {
      return false;
    }
  }
}
