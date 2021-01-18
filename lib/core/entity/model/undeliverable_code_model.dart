import 'package:freezed_annotation/freezed_annotation.dart';

part 'undeliverable_code_model.freezed.dart';
part 'undeliverable_code_model.g.dart';

@freezed
abstract class UndeliverableCodeModel with _$UndeliverableCodeModel {
  factory UndeliverableCodeModel({
    int id,
    String creationDate,
    String lastModificationDate,
    String key,
    String description,
    bool enabled,
    String type,
  }) = _UndeliverableCodeModel;

  factory UndeliverableCodeModel.fromJson(Map<String, dynamic> json) =>
      _$UndeliverableCodeModelFromJson(json);
}
