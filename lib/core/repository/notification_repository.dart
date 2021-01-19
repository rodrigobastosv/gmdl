import 'package:dio/dio.dart';

import 'client/client.dart';

class NotificationRepository {
  NotificationRepository(this._client);

  final Dio _client;

  Future<void> updateToken({
    int deviceId,
    String token,
  }) async {
    try {
      await _client.post(
        '/$MOBILE_DEVICE/$deviceId/$UPDATE_PUSH_KEY',
        queryParameters: {
          ..._client.options.queryParameters,
          'module': 'GreenMileDriver7',
        },
        data: {
          'pushKey': token,
        },
      );
    } on Exception {
      rethrow;
    }
  }
}
