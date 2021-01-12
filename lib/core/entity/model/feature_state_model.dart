import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_state_model.freezed.dart';
part 'feature_state_model.g.dart';

@freezed
abstract class FeatureStateModel with _$FeatureStateModel {
  factory FeatureStateModel({
    String name,
    bool enabled,
    Map<String, dynamic> parameters,
  }) = _FeatureStateModel;

  static List<FeatureStateModel> fromJsonList(List list) {
    return List.generate(
      list.length,
      (i) => FeatureStateModel.fromJson(list[i]),
    );
  }

  factory FeatureStateModel.fromJson(Map<String, dynamic> json) =>
      _$FeatureStateModelFromJson(json);
}
