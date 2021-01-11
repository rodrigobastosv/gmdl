import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'additional_material_model.freezed.dart';
part 'additional_material_model.g.dart';

@freezed
abstract class AdditionalMaterialModel with _$AdditionalMaterialModel {
  factory AdditionalMaterialModel({
    int id,
    SkuModel sku,
    TransportModel transport,
    int quantity,
    SizeAliasModel sizeAlias,
  }) = _AdditionalMaterialModel;

  factory AdditionalMaterialModel.fromJson(Map<String, dynamic> json) =>
      _$AdditionalMaterialModelFromJson(json);
}
