import 'package:freezed_annotation/freezed_annotation.dart';

part 'proactive_route_opt_config_model.freezed.dart';
part 'proactive_route_opt_config_model.g.dart';

@freezed
abstract class ProactiveRouteOptConfigModel
    with _$ProactiveRouteOptConfigModel {
  factory ProactiveRouteOptConfigModel({
    int id,
    String creationDate,
    int timeWindowToleranceInMinutes,
    bool impactCalculation,
    bool enabled,
  }) = _ProactiveRouteOptConfigModel;

  factory ProactiveRouteOptConfigModel.fromJson(Map<String, dynamic> json) =>
      _$ProactiveRouteOptConfigModelFromJson(json);
}
