import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'udf_model.freezed.dart';
part 'udf_model.g.dart';

@freezed
abstract class UdfModel with _$UdfModel {
  factory UdfModel({
    int id,
    String key,
    EntityModel entity,
    String value,
  }) = _UdfModel;

  factory UdfModel.fromJson(Map<String, dynamic> json) =>
      _$UdfModelFromJson(json);
}
