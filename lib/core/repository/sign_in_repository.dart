import 'package:dio/dio.dart';

import '../exception/exceptions.dart';
import 'client/endpoints.dart';
import 'client/query_params.dart';
import 'client/utils.dart';

class SignInRepository {
  SignInRepository(this._client);

  final Dio _client;

  Future<Map<String, dynamic>> signInUser({
    String serverUrl,
    String username,
    String password,
  }) async {
    try {
      final response = await _client.post(
        '/$SIGN_IN',
        queryParameters: {
          J_USERNAME: username,
          J_PASSWORD: password,
        },
      );
      return handleResponse(response) as Map<String, dynamic>;
    } on DioError catch (e) {
      throw SignInException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw SignInException(e.errorMessage);
    }
  }
}
