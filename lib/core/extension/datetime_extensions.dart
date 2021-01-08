extension DateTimeExt on DateTime {
  String get toUtcAsString => toUtc().toIso8601String();
}
