import 'package:freezed_annotation/freezed_annotation.dart';

import 'route_dto.dart';

part 'route_view_info_dto.freezed.dart';
part 'route_view_info_dto.g.dart';

@freezed
abstract class RouteViewInfoDTO with _$RouteViewInfoDTO {
  factory RouteViewInfoDTO({
    RouteDTO route,
    Map<String, dynamic> primaryEquipment,
    bool hasSurveyApplied,
  }) = _RouteViewInfoDTO;

  factory RouteViewInfoDTO.fromJson(Map<String, dynamic> json) =>
      _$RouteViewInfoDTOFromJson(json);
}
