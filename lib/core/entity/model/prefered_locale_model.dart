import 'package:freezed_annotation/freezed_annotation.dart';

part 'prefered_locale_model.freezed.dart';
part 'prefered_locale_model.g.dart';

@freezed
abstract class PreferedLocaleModel with _$PreferedLocaleModel {
  factory PreferedLocaleModel({
    int id,
    String key,
    String language,
    String description,
    String dateFormat,
    String timeFormat,
    String currency,
    String decimalSymbol,
    String digitalGrouping,
  }) = _PreferedLocaleModel;

  factory PreferedLocaleModel.fromJson(Map<String, dynamic> json) =>
      _$PreferedLocaleModelFromJson(json);
}
