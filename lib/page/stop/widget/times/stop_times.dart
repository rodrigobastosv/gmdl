import 'package:flutter/material.dart';

import 'package:flutter_dash/flutter_dash.dart';

import '../../../../core/entity/model/models.dart';
import '../../../../core/extension/extensions.dart';
import '../../../../core/utils/utils.dart';

class StopTimes extends StatelessWidget {
  const StopTimes({
    Key key,
    this.stop,
  }) : super(key: key);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getHourAndMinuteFromDate(
            stop.hasBeenArrived
                ? stop.actualArrival.local
                : stop.projectedArrival.local,
          ),
          style: TextStyle(
            color: stop.hasBeenArrived
                ? const Color(0xFF75B800)
                : const Color(0xFF717373),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          getHourAndMinuteFromDate(stop.plannedArrival.local),
          style: const TextStyle(
            color: Color(0xFF9B9B9B),
            fontWeight: FontWeight.bold,
          ),
        ),
        Dash(
          direction: Axis.horizontal,
          length: MediaQuery.of(context).size.width - 200,
          dashLength: 6,
          dashColor: Colors.grey,
        ),
        Text(
          getHourAndMinuteFromDate(stop.projectedDeparture.local),
          style: const TextStyle(
            color: Color(0xFF717373),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          getHourAndMinuteFromDate(stop.plannedDeparture.local),
          style: const TextStyle(
            color: Color(0xFF9B9B9B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
