import 'package:freezed_annotation/freezed_annotation.dart';

import '../enum/enums.dart';

part 'notification_dto.freezed.dart';
part 'notification_dto.g.dart';

@freezed
abstract class NotificationDto with _$NotificationDto {
  factory NotificationDto({
    String id,
    @JsonKey(fromJson: notificationTypeFromJson, toJson: notificationTypeToJson)
        NotificationType type,
    // ignore: lines_longer_than_80_chars
    @JsonKey(fromJson: notificationActionFromJson, toJson: notificationActionToJson)
        NotificationAction action,
    String content,
    int sequence,
  }) = _NotificationDto;

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);
}
