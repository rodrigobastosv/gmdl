import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale_model.freezed.dart';
part 'locale_model.g.dart';

@freezed
abstract class LocaleModel with _$LocaleModel {
  factory LocaleModel({
    int id,
    String key,
    String language,
    String description,
    String dateFormat,
    String timeFormat,
    String currency,
    String decimalSymbol,
    String digitalGrouping,
  }) = _LocaleModel;

  factory LocaleModel.fromJson(Map<String, dynamic> json) =>
      _$LocaleModelFromJson(json);
}
