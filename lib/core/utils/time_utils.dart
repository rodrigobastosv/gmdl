import 'string_utils.dart';

const Duration ONE_SECOND = Duration(seconds: 1);

String padDataField(int dataField) {
  return padLeftWithZeros(value: dataField);
}

String getHourAndMinuteFromDateString(String dataStr) {
  final datetime = DateTime.parse(dataStr);
  final hourPadded = padDataField(datetime.hour);
  final minutePadded = padDataField(datetime.minute);
  return '$hourPadded:$minutePadded';
}

String getHourAndMinuteFromSeconds(int timeInSeconds) {
  final minutes = (timeInSeconds / 60).floor().toString().padLeft(2, '0');
  final seconds = (timeInSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
