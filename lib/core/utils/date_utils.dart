import 'package:intl/intl.dart';

import '../extension/datetime_extensions.dart';

// 10:51 AM
// 01:33 PM
String getBasicDateHourMinute(String dateString) {
  final date = dateString.local;
  return DateFormat('hh:mm').add_j().format(date);
}

// Jan 12
// Dec 7
String getBasicDateMonthDay(String dateString) {
  final date = dateString.local;
  return DateFormat('MMM dd').format(date);
}
