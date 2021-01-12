import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_info_dto.freezed.dart';
part 'driver_info_dto.g.dart';

@freezed
abstract class DriverInfoDto with _$DriverInfoDto {
  factory DriverInfoDto({
    int id,
    String key,
    String name,
    String login,
    String unitSystem,
    String driverType,
    bool enabled,
    bool restrictEquipments,
    bool restrictDrivers,
    bool isSystem,
    bool smartTrack,
    int failedAttempts,
    String latestLogin,
  }) = _DriverInfoDto;

  factory DriverInfoDto.fromJson(Map<String, dynamic> json) =>
      _$DriverInfoDtoFromJson(json);
}
