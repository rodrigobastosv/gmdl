
import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale_option.freezed.dart';

@freezed
abstract class LocaleOption with _$LocaleOption {
  // ignore: unused_element
  const LocaleOption._();

  factory LocaleOption(
    String key,
    String label,
  ) = _LocaleOption;

  @override
  String toString() => label;
}
