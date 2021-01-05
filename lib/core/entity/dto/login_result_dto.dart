import 'package:equatable/equatable.dart';

class LoginResultDTO extends Equatable {
  LoginResultDTO({
    this.username,
    this.targetUrl,
    this.message,
    this.jSessionId,
    this.resourceKey,
  });

  final String username;
  final String targetUrl;
  final String message;
  final String jSessionId;
  final String resourceKey;

  factory LoginResultDTO.fromJson(String username, Map<String, dynamic> json) {
    return LoginResultDTO(
      username: username,
      targetUrl: json['targetUrl'],
      message: json['message'],
      jSessionId: json['jsessionid'],
      resourceKey: json['resourceKey'],
    );
  }

  @override
  List<Object> get props => [
        jSessionId,
      ];
}
