import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/entity/model/models.dart';
import '../../../core/utils/utils.dart';

class MapStopMarker extends StatelessWidget {
  const MapStopMarker({
    Key key,
    @required this.stop,
    @required this.isInProgress,
    @required this.isNextSuggestion,
  }) : super(key: key);

  final StopModel stop;
  final bool isInProgress;
  final bool isNextSuggestion;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xFF464646),
      child: _getStopIcon(stop),
    );
  }

  Widget _getStopIcon(StopModel stop) {
    if (isInProgress) {
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
          const SpinKitRing(
            color: Colors.green,
            size: 32,
            lineWidth: 5,
          )
        ],
      );
    } else if (isNextSuggestion) {
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
          const SpinKitRing(
            color: Colors.blue,
            size: 32,
            lineWidth: 5,
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
