import 'package:freezed_annotation/freezed_annotation.dart';

import '../serializing_utils.dart';
import 'models.dart';

part 'line_item_model.freezed.dart';
part 'line_item_model.g.dart';

@freezed
abstract class LineItemModel with _$LineItemModel {
  factory LineItemModel({
    int id,
    String key,
    String lineItemID,
    SkuModel sku,
    bool hasPicture,
    BaseUnitModel size1AliasConfig,
    BaseUnitModel size2AliasConfig,
    BaseUnitModel size3AliasConfig,
    @JsonKey(fromJson: convertToDouble) double unitPrice,
    @JsonKey(fromJson: convertToDouble) double totalPrice,
    String bonusKey,
    bool allowShort,
    List<UdfModel> udfs,
    @JsonKey(fromJson: convertToDouble) double unitDiscountSize1,
    @JsonKey(fromJson: convertToDouble) double plannedSize1,
    @JsonKey(fromJson: convertToDouble) double plannedSize2,
    @JsonKey(fromJson: convertToDouble) double plannedSize3,
    @JsonKey(fromJson: convertToDouble) double plannedPickupSize1,
    @JsonKey(fromJson: convertToDouble) double plannedPickupSize2,
    @JsonKey(fromJson: convertToDouble) double unitTaxSize1,
    @JsonKey(fromJson: convertToDouble) double unitTaxSize2,
    @JsonKey(fromJson: convertToDouble) double unitTaxSize3,
    @JsonKey(fromJson: convertToDouble) double damagedSize1,
    @JsonKey(fromJson: convertToDouble) double damagedSize2,
    @JsonKey(fromJson: convertToDouble) double damagedSize3,
    bool disregardInStock,
  }) = _LineItemModel;

  factory LineItemModel.fromJson(Map<String, dynamic> json) =>
      _$LineItemModelFromJson(json);
}
