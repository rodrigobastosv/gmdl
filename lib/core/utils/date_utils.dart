import 'package:intl/intl.dart';

import '../extension/datetime_extensions.dart';

String getBasicDateHourMinute(String dateString) {
  final date = dateString.local;
  return DateFormat().add_jm().format(date);
}

String getBasicDateMonthDay(String dateString) {
  final date = dateString.local;
  return DateFormat('MMM dd').format(date);
}
