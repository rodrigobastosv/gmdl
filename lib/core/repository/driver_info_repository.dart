import 'package:dio/dio.dart';

import 'api.dart';

class DriverInfoRepository {
  DriverInfoRepository(this.client);

  final Dio client;

  Future<Map<String, dynamic>> getDriverInfo({
    String username,
  }) async {
    try {
      final response = await client.post(
        '/$SIGN_IN',
        queryParameters: {
          'username': username,
        },
      );
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      } else {
        return response.data as Map<String, dynamic>;
      }
    } on Exception {
    }
  }
}