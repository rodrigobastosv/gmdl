import 'package:freezed_annotation/freezed_annotation.dart';

part 'cancel_code_model.freezed.dart';
part 'cancel_code_model.g.dart';

@freezed
abstract class CancelCodeModel with _$CancelCodeModel {
  factory CancelCodeModel({
    int id,
    String creationDate,
    String lastModificationDate,
    String key,
    String description,
    bool enabled,
  }) = _CancelCodeModel;

  factory CancelCodeModel.fromJson(Map<String, dynamic> json) =>
      _$CancelCodeModelFromJson(json);
}
