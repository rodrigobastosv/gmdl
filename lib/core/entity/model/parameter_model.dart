import 'package:freezed_annotation/freezed_annotation.dart';

part 'parameter_model.freezed.dart';
part 'parameter_model.g.dart';

@freezed
abstract class ParameterModel with _$ParameterModel {
  factory ParameterModel({
    String url,
  }) = _ParameterModel;

  factory ParameterModel.fromJson(Map<String, dynamic> json) =>
      _$ParameterModelFromJson(json);
}
