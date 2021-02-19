import 'package:flutter/material.dart';

import 'string_utils.dart';

const Duration ONE_SECOND = Duration(seconds: 1);
const Duration ONE_MINUTE = Duration(minutes: 1);

String padDataField(int dataField) {
  return padLeftWithZeros(value: dataField);
}

String getHourAndMinuteFromDate(DateTime date) {
  final hourPadded = padDataField(date.hour);
  final minutePadded = padDataField(date.minute);
  return '$hourPadded:$minutePadded';
}

String getHourAndMinuteFromSeconds(int timeInSeconds) {
  final minutes = (timeInSeconds / 60).floor().toString().padLeft(2, '0');
  final seconds = (timeInSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

String getHourMinuteFromTimeOfDay(TimeOfDay timeOfDay) {
  if (timeOfDay != null) {
    final hour = timeOfDay.hour;
    final minute = timeOfDay.minute;
    return '$hour:$minute:00';
  }
  return null;
}

Future<TimeOfDay> showGMTimePicker(
  BuildContext context, {
  String confirmText,
  String cancelText,
  String helperText,
}) async {
  final now = DateTime.now();
  final result = await showTimePicker(
    context: context,
    initialTime: TimeOfDay(
      hour: now.hour,
      minute: now.minute,
    ),
    builder: (context, child) {
      final primaryColor = Theme.of(context).primaryColor;
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: primaryColor,
          accentColor: primaryColor,
          colorScheme: ColorScheme.light(
            primary: primaryColor,
          ),
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        child: child,
      );
    },
    confirmText: confirmText,
    cancelText: cancelText,
    helpText: helperText,
  );
  return result;
}
