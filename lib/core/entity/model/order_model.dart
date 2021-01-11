import 'package:freezed_annotation/freezed_annotation.dart';

import '../serializing_utils.dart';
import 'models.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
abstract class OrderModel with _$OrderModel {
  factory OrderModel({
    int id,
    String number,
    List<LineItemModel> lineItems,
    @JsonKey(fromJson: convertToDouble) double plannedSize1,
    @JsonKey(fromJson: convertToDouble) double plannedSize2,
    @JsonKey(fromJson: convertToDouble) double plannedSize3,
    @JsonKey(fromJson: convertToDouble) double plannedPickupSize1,
    @JsonKey(fromJson: convertToDouble) double plannedPickupSize2,
    @JsonKey(fromJson: convertToDouble) double plannedPickupSize3,
    List<UdfModel> udfs,
    bool hasPicture,
    PaymentMethodModel paymentMethod,
    BaseUnitModel size1AliasConfig,
    BaseUnitModel size2AliasConfig,
    BaseUnitModel size3AliasConfig,
    bool allowShort,
    bool newOrder,
    OrderClassModel orderClass,
    @JsonKey(fromJson: convertToDouble) double damagedSize1,
    @JsonKey(fromJson: convertToDouble) double damagedSize2,
    @JsonKey(fromJson: convertToDouble) double damagedSize3,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
