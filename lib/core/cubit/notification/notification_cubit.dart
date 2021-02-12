import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../entity/dto/notification_dto.dart';
import '../../global/global_info.dart';
import '../../repository/repositories.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({
    @required FirebaseMessaging firebaseMessaging,
    @required NotificationRepository repository,
    @required GlobalInfo globalInfo,
  })  : assert(firebaseMessaging != null),
        assert(repository != null),
        assert(globalInfo != null),
        _firebaseMessaging = firebaseMessaging,
        _repository = repository,
        _globalInfo = globalInfo,
        super(NotificationInitial());

  final FirebaseMessaging _firebaseMessaging;
  final NotificationRepository _repository;
  final GlobalInfo _globalInfo;
  String fcmToken;

  Future<void> initNotifications() async {
    try {
      fcmToken = await _firebaseMessaging.getToken();
      final deviceId = _globalInfo.mobileDevice.id;
      _repository.updateToken(deviceId: deviceId, token: fcmToken);

      FirebaseMessaging.onMessage.listen((message) {
        final messageData = jsonDecode(message.data['default']);
        final notification = NotificationDto.fromJson(messageData);
        emit(NotificationReceive(notification));
        _repository.ackNotification(notification.id);
      });

      _firebaseMessaging.onTokenRefresh.listen((token) async {
        fcmToken = token;
        _repository.updateToken(deviceId: deviceId, token: fcmToken);
        emit(NotificationTokenRefresh(token));
      });

      emit(NotificationSetupSuccess(fcmToken));
    } on Exception {
      emit(NotificationSetupFailure());
    }
  }
}
