import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'feature_state_model.freezed.dart';
part 'feature_state_model.g.dart';

@freezed
abstract class FeatureStateModel with _$FeatureStateModel {
  factory FeatureStateModel({
    String name,
    bool enabled,
    List<ParameterModel> parameters,
  }) = _FeatureStateModel;

  factory FeatureStateModel.fromJson(Map<String, dynamic> json) =>
      _$FeatureStateModelFromJson(json);
}
