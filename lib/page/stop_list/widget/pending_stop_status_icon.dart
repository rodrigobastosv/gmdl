import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/entity/model/stop_model.dart';
import '../../../core/utils/utils.dart';

class PendingStopStatusIcon extends StatelessWidget {
  const PendingStopStatusIcon({
    Key key,
    this.stop,
  }) : super(key: key);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -2,
      left: -2,
      child: SvgPicture.asset(
        getPendingStopStatusIconAsset(stop),
        height: 18,
        width: 18,
      ),
    );
  }
}
