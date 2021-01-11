import 'package:freezed_annotation/freezed_annotation.dart';

part 'entity_model.freezed.dart';
part 'entity_model.g.dart';

@freezed
abstract class EntityModel with _$EntityModel {
  factory EntityModel({
    int id,
    bool hasPicture,
  }) = _EntityModel;

  factory EntityModel.fromJson(Map<String, dynamic> json) =>
      _$EntityModelFromJson(json);
}
