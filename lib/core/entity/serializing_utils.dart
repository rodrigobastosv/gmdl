double convertToDouble(dynamic value) {
  if (value is double) {
    return value;
  } else {
    final intValue = value as int;
    if (intValue == null) {
      return 0.0;
    }
    return intValue.toDouble();
  }
}
