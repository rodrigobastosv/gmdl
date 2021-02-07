import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/utils.dart';

import '../../../core/entity/model/models.dart';

class MapStopMarker extends StatelessWidget {
  const MapStopMarker({
    Key key,
    @required this.stop,
    @required this.isNextSuggestion,
  }) : super(key: key);

  final StopModel stop;
  final bool isNextSuggestion;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xFF464646),
      child: _getStopIcon(stop),
    );
  }

  Widget _getStopIcon(StopModel stop) {
    if (isNextSuggestion) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Text(
              stop.plannedSequenceNum.toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SpinKitDualRing(
            color: Colors.blue,
            size: 32,
            lineWidth: 3,
          )
        ],
      );
    } else if (stop.isDone) {
      return SvgPicture.asset(
        getDoneStopStatusIconAsset(stop),
        height: 22,
        width: 22,
      );
    } else {
      return Center(
        child: Text(
          stop.plannedSequenceNum.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }
}
