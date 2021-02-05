import 'package:flutter/material.dart';
import '../../core/utils/time_utils.dart';

class GMTimer extends StatelessWidget {
  GMTimer({
    Key key,
    @required this.expirationTime,
    this.timeInSeconds = 0,
  }) : super(key: key);

  final Duration expirationTime;
  final int timeInSeconds;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        getHourAndMinuteFromSeconds(timeInSeconds),
        style: TextStyle(
          color: expirationTime.inSeconds > timeInSeconds
              ? const Color(0xFFB0D25A)
              : const Color(0xFFEE3C25),
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
