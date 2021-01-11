import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_unit_model.freezed.dart';
part 'base_unit_model.g.dart';

@freezed
abstract class BaseUnitModel with _$BaseUnitModel {
  factory BaseUnitModel({
    int id,
    String key,
    String description,
    String icon,
    String preferredSize,
  }) = _BaseUnitModel;

  factory BaseUnitModel.fromJson(Map<String, dynamic> json) =>
      _$BaseUnitModelFromJson(json);
}
