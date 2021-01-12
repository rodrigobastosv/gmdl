import 'package:intl/intl.dart';

import '../extension/datetime_extensions.dart';

String getBasicDateHourMinute(String dateString) {
  final date = dateString.local;
  return DateFormat('hh:mm').add_j().format(date);
}
