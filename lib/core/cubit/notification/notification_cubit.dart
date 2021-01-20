import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../repository/repositories.dart';
import '../../store/store.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({
    @required FirebaseMessaging firebaseMessaging,
    @required NotificationRepository repository,
    @required Store store,
  })  : assert(firebaseMessaging != null),
        assert(repository != null),
        assert(store != null),
        _firebaseMessaging = firebaseMessaging,
        _repository = repository,
        _store = store,
        super(NotificationInitial());

  final FirebaseMessaging _firebaseMessaging;
  final NotificationRepository _repository;
  final Store _store;
  String fcmToken;

  Future<void> initNotifications() async {
    try {
      fcmToken = await _firebaseMessaging.getToken();
      final deviceId = _store.mobileDevice.id;
      _repository.updateToken(deviceId: deviceId, token: fcmToken);

      FirebaseMessaging.onMessage.listen((message) {
        emit(
          NotificationReceived(
            id: message.messageId,
            data: message.data,
          ),
        );
      });

      _firebaseMessaging.onTokenRefresh.listen((token) async {
        fcmToken = token;
        _repository.updateToken(deviceId: deviceId, token: fcmToken);
        emit(NotificationTokenRefreshed(token));
      });

      emit(NotificationSetupSuccess(fcmToken));
    } on Exception {
      emit(NotificationSetupFailed());
    }
  }
}
