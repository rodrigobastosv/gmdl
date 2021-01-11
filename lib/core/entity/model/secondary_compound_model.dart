import 'package:freezed_annotation/freezed_annotation.dart';

import '../serializing_utils.dart';
import 'models.dart';

part 'secondary_compound_model.freezed.dart';
part 'secondary_compound_model.g.dart';

@freezed
abstract class SecondaryCompoundModel with _$SecondaryCompoundModel {
  factory SecondaryCompoundModel({
    int id,
    String creationDate,
    String lastModificationDate,
    OrganizationModel organization,
    String key,
    String description,
    bool enabled,
    OrganizationModel skuType,
    BaseUnitModel baseUnit,
    @JsonKey(fromJson: convertToDouble) double secondaryQty,
    String alternativeKey,
    bool hasSecondaryBundle,
    bool hasTertiaryBundle,
  }) = _SecondaryCompoundModel;

  factory SecondaryCompoundModel.fromJson(Map<String, dynamic> json) =>
      _$SecondaryCompoundModelFromJson(json);
}
