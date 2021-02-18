import 'package:freezed_annotation/freezed_annotation.dart';

import '../enum/enums.dart';

part 'hos_event_model.freezed.dart';
part 'hos_event_model.g.dart';

@freezed
abstract class HosEventModel with _$HosEventModel {
  factory HosEventModel({
    int id,
    @JsonKey(fromJson: hosEventTypeFromJson, toJson: hosEventTypeToJson)
        HosEventType eventType,
    String eventTime,
  }) = _HosEventModel;

  factory HosEventModel.fromJson(Map<String, dynamic> json) =>
      _$HosEventModelFromJson(json);
}
