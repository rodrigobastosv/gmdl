part of 'notification_cubit.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationSetupSuccess extends NotificationState {
  NotificationSetupSuccess(this.token);

  final String token;

  @override
  List<Object> get props => [
        token,
      ];
}

class NotificationSetupFailure extends NotificationState {}

class NotificationReceive extends NotificationState {
  NotificationReceive(this.notification);

  final NotificationDto notification;

  @override
  List<Object> get props => [
        notification,
      ];
}

class NotificationTokenRefresh extends NotificationState {
  NotificationTokenRefresh(this.token);

  final String token;

  @override
  List<Object> get props => [
        token,
      ];
}
