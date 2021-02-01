import 'package:flutter/foundation.dart';

@immutable
class LocaleOption {
  LocaleOption(
    this.key,
    this.label,
  );

  final String key;
  final String label;

  @override
  String toString() => label;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LocaleOption && o.key == key && o.label == label;
  }

  @override
  int get hashCode => key.hashCode ^ label.hashCode;
}
