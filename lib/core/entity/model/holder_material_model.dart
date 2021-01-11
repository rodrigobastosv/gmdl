import 'package:freezed_annotation/freezed_annotation.dart';

import '../serializing_utils.dart';
import 'models.dart';

part 'holder_material_model.freezed.dart';
part 'holder_material_model.g.dart';

@freezed
abstract class HolderMaterialModel with _$HolderMaterialModel {
  factory HolderMaterialModel({
    int id,
    SkuModel sku,
    TransportModel transport,
    @JsonKey(fromJson: convertToDouble) double size1Quantity,
    @JsonKey(fromJson: convertToDouble) double size2Quantity,
    @JsonKey(fromJson: convertToDouble) double size3Quantity,
    BaseUnitModel size1Alias,
    BaseUnitModel size2Alias,
    BaseUnitModel size3Alias,
  }) = _HolderMaterialModel;

  factory HolderMaterialModel.fromJson(Map<String, dynamic> json) =>
      _$HolderMaterialModelFromJson(json);
}
