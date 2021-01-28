import 'package:flutter/material.dart';

import '../../../core/entity/model/models.dart';
import '../../../core/utils/utils.dart';
import 'pending_stop_status_icon.dart';

class StopIcon extends StatelessWidget {
  const StopIcon({
    Key key,
    @required this.stop,
    @required this.iconColor,
    @required this.textColor,
  }) : super(key: key);

  final StopModel stop;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return stop.isPending
        ? Stack(
            children: [
              CircleAvatar(
                backgroundColor: iconColor,
                child: Text(
                  stop.plannedSequenceNum.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              if (stop.stopHadActionPerformed)
                PendingStopStatusIcon(stop: stop),
            ],
          )
        : getStopWidget(
            isRouteFinished: false,
            stop: stop,
          );
  }
}
