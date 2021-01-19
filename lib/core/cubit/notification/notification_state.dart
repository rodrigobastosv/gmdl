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

class NotificationSetupFailed extends NotificationState {}

class NotificationReceived extends NotificationState {
  NotificationReceived(this.message);

  final Map<String, dynamic> message;

  @override
  List<Object> get props => [
        message,
      ];
}

class NotificationTokenRefreshed extends NotificationState {
  NotificationTokenRefreshed(this.token);

  final String token;

  @override
  List<Object> get props => [
        token,
      ];
}
