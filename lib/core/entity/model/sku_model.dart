import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'sku_model.freezed.dart';
part 'sku_model.g.dart';

@freezed
abstract class SkuModel with _$SkuModel {
  factory SkuModel({
    int id,
    OrganizationModel organization,
    String key,
    String description,
    SkuTypeModel skuType,
    BaseUnitModel baseUnit,
    BaseUnitModel secondaryUnit,
    double secondaryQty,
    String alternativeKey,
    SecondaryCompoundModel secondaryCompound,
    double secondaryCompoundQty,
  }) = _SkuModel;

  factory SkuModel.fromJson(Map<String, dynamic> json) =>
      _$SkuModelFromJson(json);
}
