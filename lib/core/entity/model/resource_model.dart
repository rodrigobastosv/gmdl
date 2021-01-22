import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource_model.freezed.dart';
part 'resource_model.g.dart';

@freezed
abstract class ResourceModel with _$ResourceModel {
  factory ResourceModel({
    String key,
    String value,
    String updatedAt,
    Map<String, dynamic> i18nlocale,
  }) = _ResourceModel;

  factory ResourceModel.fromJson(Map<String, dynamic> json) =>
      _$ResourceModelFromJson(json);
}
