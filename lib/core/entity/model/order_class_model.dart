import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_class_model.g.dart';
part 'order_class_model.freezed.dart';

@freezed
abstract class OrderClassModel with _$OrderClassModel {
  factory OrderClassModel({
    int id,
    String key,
    String description,
    bool allDamaged,
  }) = _OrderClassModel;

  factory OrderClassModel.fromJson(Map<String, dynamic> json) =>
      _$OrderClassModelFromJson(json);
}
