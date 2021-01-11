import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_type_model.freezed.dart';
part 'location_type_model.g.dart';

@freezed
abstract class LocationTypeModel with _$LocationTypeModel {
  factory LocationTypeModel({
    int id,
    String key,
    String description,
    bool showOnMobileCreate,
    String alternativeKey,
  }) = _LocationTypeModel;

  factory LocationTypeModel.fromJson(Map<String, dynamic> json) =>
      _$LocationTypeModelFromJson(json);
}
