import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_dto.freezed.dart';
part 'route_dto.g.dart';

@freezed
abstract class RouteDTO with _$RouteDTO {
  factory RouteDTO({
    int id,
    String key,
    String description,
    String date,
    Map<String, dynamic> organization,
    Map<String, dynamic> origin,
    String plannedStart,
    bool hasSurveyApplied,
    int totalStops,
    String status,
    bool hasPicture,
    bool onRoute,
  }) = _RouteDTO;

  factory RouteDTO.fromJson(Map<String, dynamic> json) =>
      _$RouteDTOFromJson(json);
}
