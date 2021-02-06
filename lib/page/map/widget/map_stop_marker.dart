import 'package:flutter/material.dart';
import '../../../core/entity/model/models.dart';

class MapStopMarker extends StatelessWidget {
  const MapStopMarker({
    Key key,
    @required this.stop,
  }) : super(key: key);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xFF464646),
      child: Center(
        child: Text(
          stop.plannedSequenceNum.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
