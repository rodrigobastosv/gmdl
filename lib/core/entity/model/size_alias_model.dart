import 'package:freezed_annotation/freezed_annotation.dart';

part 'size_alias_model.freezed.dart';
part 'size_alias_model.g.dart';

@freezed
abstract class SizeAliasModel with _$SizeAliasModel {
  factory SizeAliasModel({
    int id,
    String key,
    String preferredSize,
  }) = _SizeAliasModel;

  factory SizeAliasModel.fromJson(Map<String, dynamic> json) =>
      _$SizeAliasModelFromJson(json);
}
