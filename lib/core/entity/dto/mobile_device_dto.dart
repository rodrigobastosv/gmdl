import 'package:freezed_annotation/freezed_annotation.dart';

part 'mobile_device_dto.freezed.dart';
part 'mobile_device_dto.g.dart';

@freezed
abstract class MobileDeviceDto with _$MobileDeviceDto {
  factory MobileDeviceDto({
    int id,
    String uniqueDeviceId,
    String platform,
    String platformVersion,
    String registrationDate,
    String lastPing,
    Map<String, dynamic> userRegistered,
    String deviceModel,
    String registrationIp,
    double registrationLatitude,
    double registrationLongitude,
    int registrationAccuracy,
    bool blocked,
    bool waitingApproval,
    String registrationGPSProvider,
  }) = _MobileDeviceDto;

  factory MobileDeviceDto.fromJson(Map<String, dynamic> json) =>
      _$MobileDeviceDtoFromJson(json);
}
