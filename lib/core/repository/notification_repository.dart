import '../constants.dart';
import 'client/client.dart';
import 'client/gm_client.dart';

class NotificationRepository {
  NotificationRepository(this._client);

  final GMClient _client;

  Future<void> updateToken({
    int deviceId,
    String token,
  }) async {
    try {
      await _client.post(
        '/$MOBILE_DEVICE/$deviceId/$UPDATE_PUSH_KEY',
        queryParameters: {
          'module': moduleKey,
        },
        data: {
          'pushKey': token,
        },
      );
    } on Exception {
      rethrow;
    }
  }

  Future<void> ackNotification(String notificationId) async {
    try {
      await _client.post(
        '/$NOTIFICATION_MESSAGE/$ACK',
        data: [
          notificationId,
        ],
      );
    } on Exception {
      rethrow;
    }
  }
}
