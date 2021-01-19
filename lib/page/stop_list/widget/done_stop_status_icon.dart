import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/entity/model/stop_model.dart';
import '../../../core/utils/utils.dart';

class DoneStopStatusIcon extends StatelessWidget {
  const DoneStopStatusIcon({
    Key key,
    this.stop,
  }) : super(key: key);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    if (stop.isCloned ||
        stop.isCanceled ||
        stop.isRedelivered ||
        stop.isUndeliverable) {
      return SvgPicture.asset(
        getDoneStopStatusIconAsset(stop),
        height: 32,
        width: 32,
      );
    } else {
      return CircleAvatar(
        backgroundColor: const Color(0xFF464646),
        child: Text(
          stop.plannedSequenceNum.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    }
  }
}
