import 'package:freezed_annotation/freezed_annotation.dart';

import '../serializing_utils.dart';
import 'models.dart';

part 'manifest_model.freezed.dart';
part 'manifest_model.g.dart';

@freezed
abstract class ManifestModel with _$ManifestModel {
  factory ManifestModel({
    int id,
    SkuModel sku,
    TransportModel transport,
    @JsonKey(fromJson: convertToDouble) double size1,
    BaseUnitModel size1Alias,
    List<UdfModel> udfs,
  }) = _ManifestModel;

  factory ManifestModel.fromJson(Map<String, dynamic> json) =>
      _$ManifestModelFromJson(json);
}
