import 'package:freezed_annotation/freezed_annotation.dart';

part 'hos_type_model.freezed.dart';
part 'hos_type_model.g.dart';

@freezed
abstract class HosTypeModel with _$HosTypeModel {
  factory HosTypeModel({
    int id,
    String key,
    String description,
    bool allowBreakAppointment,
    bool allowLunchAppointment,
    bool allowWaitAppointment,
    int breakTimeThresholdMinutes,
    int breakTimeDurationMinutes,
    int lunchTimeThresholdMinutes,
    int lunchTimeDurationMinutes,
    bool forceBreakTime,
    bool forceLunchTime,
    bool enabled,
  }) = _HosTypeModel;

  factory HosTypeModel.fromJson(Map<String, dynamic> json) =>
      _$HosTypeModelFromJson(json);
}
