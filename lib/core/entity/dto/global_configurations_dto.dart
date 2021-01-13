import 'package:freezed_annotation/freezed_annotation.dart';

part 'global_configurations_dto.freezed.dart';
part 'global_configurations_dto.g.dart';

@freezed
abstract class GlobalConfigurationsDto with _$GlobalConfigurationsDto {
  factory GlobalConfigurationsDto({
    int id,
    String size1Alias,
    String size2Alias,
    String size3Alias,
    bool allowOnlyRegisteredDevices,
    String mobileVersionsPath,
    bool requiredRTSRegionMapping,
    bool allowChatBetweenDrivers,
    bool askPhoneRegistration,
    bool enableChildOrgVisibility,
    bool enableSendNotificationSms,
    bool enableSendNotificationEmail,
    int liveDefaultRefreshIntervalSecs,
    String distanceTimeMethod,
    bool allowWhiteListCheck,
    bool enableComplexCSV,
    bool surveySkuSupportEnabled,
  }) = _GlobalConfigurationsDto;

  factory GlobalConfigurationsDto.fromJson(Map<String, dynamic> json) =>
      _$GlobalConfigurationsDtoFromJson(json);
}
