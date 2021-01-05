import 'package:dio/dio.dart';

import '../exception/exceptions.dart';
import 'client/endpoints.dart';

class SignInRepository {
  SignInRepository(this.client);

  final Dio client;

  Future<Map<String, dynamic>> signInUser({
    String serverUrl,
    String username,
    String password,
  }) async {
    try {
      final response = await client.post(
        '/$SIGN_IN',
        queryParameters: {
          'j_username': username,
          'j_password': password,
        },
      );
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      } else {
        return response.data as Map<String, dynamic>;
      }
    } on Exception {
      throw SignInException();
    }
  }
}
