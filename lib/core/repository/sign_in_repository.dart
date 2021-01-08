import 'package:dio/dio.dart';

import '../exception/exceptions.dart';
import 'client/endpoints.dart';
import 'client/query_params.dart';
import 'client/utils.dart';

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
          J_USERNAME: username,
          J_PASSWORD: password,
        },
      );
      return handleResponse(response) as Map<String, dynamic>;
    } on Exception {
      throw SignInException();
    }
  }
}
