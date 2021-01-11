import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'sku_type_model.freezed.dart';
part 'sku_type_model.g.dart';

@freezed
abstract class SkuTypeModel with _$SkuTypeModel {
  factory SkuTypeModel({
    int id,
    String creationDate,
    OrganizationModel organization,
    String key,
    String description,
  }) = _SkuTypeModel;

  factory SkuTypeModel.fromJson(Map<String, dynamic> json) =>
      _$SkuTypeModelFromJson(json);
}
