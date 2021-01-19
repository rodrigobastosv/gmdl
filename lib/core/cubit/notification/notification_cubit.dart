import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this._firebaseMessaging) : super(NotificationInitial());

  final FirebaseMessaging _firebaseMessaging;
  String fcmToken;

  Future<void> initNotifications() async {
    try {
      fcmToken = await _firebaseMessaging.getToken();

      _firebaseMessaging.configure(
        onMessage: (message) {
          final data = message['data'] ?? message;
          emit(NotificationReceived(data));
          return;
        },
      );

      _firebaseMessaging.onTokenRefresh.listen((token) async {
        fcmToken = token;
        emit(NotificationTokenRefreshed(token));
      });

      emit(NotificationSetupSuccess(fcmToken));
    } on Exception {
      emit(NotificationSetupFailed());
    }
  }
}
