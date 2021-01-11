import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_zone_model.freezed.dart';
part 'time_zone_model.g.dart';

@freezed
abstract class TimeZoneModel with _$TimeZoneModel {
  factory TimeZoneModel({
    int id,
    String description,
    int rawOffsetMinutes,
    String timezoneName,
  }) = _TimeZoneModel;

  factory TimeZoneModel.fromJson(Map<String, dynamic> json) =>
      _$TimeZoneModelFromJson(json);
}
