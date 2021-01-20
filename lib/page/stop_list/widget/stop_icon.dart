import 'package:flutter/material.dart';

import '../../../core/entity/model/models.dart';
import '../../../core/utils/utils.dart';
import 'pending_stop_status_icon.dart';

class StopIcon extends StatelessWidget {
  const StopIcon({
    Key key,
    this.stop,
  }) : super(key: key);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    return stop.isPending
        ? Stack(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFF464646),
                child: Text(
                  stop.plannedSequenceNum.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
