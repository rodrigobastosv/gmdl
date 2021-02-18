import 'package:flutter/material.dart';

import 'package:flutter_dash/flutter_dash.dart';

import '../../../../core/entity/model/models.dart';
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
          getHourAndMinuteFromDateString(
              stop.hasBeenArrived ? stop.actualArrival : stop.projectedArrival),
          style: TextStyle(
            color: stop.hasBeenArrived
                ? const Color(0xFF75B800)
                : const Color(0xFF717373),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          getHourAndMinuteFromDateString(stop.plannedArrival),
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
          getHourAndMinuteFromDateString(stop.projectedDeparture),
          style: const TextStyle(
            color: Color(0xFF717373),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          getHourAndMinuteFromDateString(stop.plannedDeparture),
          style: const TextStyle(
            color: Color(0xFF9B9B9B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
