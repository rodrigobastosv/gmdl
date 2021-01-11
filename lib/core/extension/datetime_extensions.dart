extension DateTimeExt on DateTime {
  String get toUtcAsString {
    final dateString = toUtc().toIso8601String();
    final firstPart = dateString.split('.')[0];
    return '$firstPart+0000';
  }
}
