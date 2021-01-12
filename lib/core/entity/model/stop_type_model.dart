import 'package:freezed_annotation/freezed_annotation.dart';

part 'stop_type_model.freezed.dart';
part 'stop_type_model.g.dart';

@freezed
abstract class StopTypeModel with _$StopTypeModel {
  factory StopTypeModel({
    int id,
    String key,
    String description,
    String type,
    bool locationRequired,
  }) = _StopTypeModel;

  static List<StopTypeModel> fromJsonList(List list) {
    return List.generate(
      list.length,
      (i) => StopTypeModel.fromJson(list[i]),
    );
  }

  factory StopTypeModel.fromJson(Map<String, dynamic> json) =>
      _$StopTypeModelFromJson(json);
}
