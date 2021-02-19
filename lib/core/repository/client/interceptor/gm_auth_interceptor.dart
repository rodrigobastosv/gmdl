import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../../global/hive.dart';
import '../../../utils/utils.dart';
import '../client.dart';

/// This interceptor threat all requests with HTTP_FORBIDDEN error and tries to
/// login the user again.
///
/// After the login is done, the failed request is tried again. This should be
/// totally transparent to the driver.
///
/// Since we don't have something like JWT on GM yet and we need to store
/// session, one way is to encode password to avoid usual softwares to find
/// user password. We know encoding the password with base64 is as naive as
/// storing the password decoded, but it's a way to deal with security issues
/// while we don't have anything strong on server without disturbing the driver.
class GMAuthInterceptor extends Interceptor {
  GMAuthInterceptor({
    this.dio,
    this.globalBox,
  });

  final Dio dio;
  final Box globalBox;

  @override
  onError(DioError error) async {
    final request = error.request;
    final path = request.path;
    final statusCode = error.response?.statusCode;

    if (statusCode == HTTP_FORBIDDEN && !path.contains(SIGN_IN)) {
      final username = globalBox.get(USERNAME);
      final password = decodeString(globalBox.get(PASSWORD));
      try {
        final response = await dio.post(
          '/$SIGN_IN',
          queryParameters: {
            J_USERNAME: username,
            J_PASSWORD: password,
          },
        );

        final sessionId = response.data['jsessionid'];
        globalBox.put(TOKEN, sessionId);

        await dio.post(
          request.path,
          data: request.data,
          queryParameters: request.queryParameters,
          options: Options(
            headers: {
              ACCEPT: APPLICATION_JSON,
              COOKIE: '$SESSION=$sessionId',
            },
          ),
        );
      } on Exception {
        rethrow;
      }
    }

    return super.onError(error);
  }
}
