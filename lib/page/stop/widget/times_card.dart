import 'package:flutter/material.dart';

import 'package:flutter_dash/flutter_dash.dart';

import '../../../core/entity/model/stop_model.dart';
import '../../../core/extension/extensions.dart';
import '../../../core/utils/time_utils.dart';

class TimesCard extends StatelessWidget {
  const TimesCard({
    Key key,
    this.stop,
  }) : super(key: key);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              context.getTextUppercase('stop.timetable.title'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 140,
            child: Row(
              children: <Widget>[
                _LabelTimes(stop: stop),
                _DotTimes(stop: stop),
                _StopTimes(stop: stop),
              ],
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}

class _LabelTimes extends StatelessWidget {
  const _LabelTimes({
    Key key,
    this.stop,
  }) : super(key: key);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _getStopText(context, stop),
          const SizedBox(height: 12),
          Text(
            '${context.getText('details.label.planned')}',
            style: const TextStyle(
              color: Color(0xFF9B9B9B),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Dash(
            direction: Axis.horizontal,
            length: 124,
            dashLength: 6,
            dashColor: Colors.grey,
          ),
          const SizedBox(height: 6),
          Text(
            '''${context.getText('details.label.departure')} ${context.getText('details.label.projected')}''',
            style: const TextStyle(
              color: Color(0xFF717373),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${context.getText('details.label.planned')}',
            style: const TextStyle(
              color: Color(0xFF9B9B9B),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getStopText(BuildContext context, StopModel stop) {
    final stopHasBeenArrived = stop.hasBeenArrived;
    final text = stopHasBeenArrived
        ? '''${context.getText('details.label.arrival')} Done'''
        : '''${context.getText('details.label.arrival')} ${context.getText('details.label.projected')}''';
    return Text(
      text,
      style: TextStyle(
        color: stopHasBeenArrived
            ? const Color(0xFF75B800)
            : const Color(0xFF717373),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _DotTimes extends StatelessWidget {
  const _DotTimes({
    Key key,
    this.stop,
  }) : super(key: key);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 4,
        bottom: 4,
      ),
      child: Container(
        height: 140,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 140,
              width: 2,
              color: const Color(0xFF9B9B9B),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                stop.hasBeenArrived
                    ? const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 6,
                        child: Center(
                          child: Icon(
                            Icons.check_circle,
                            size: 12,
                            color: Color(0xFF75B800),
                          ),
                        ),
                      )
                    : const CircleAvatar(
                        backgroundColor: Color(0xFF717373),
                        radius: 4,
                      ),
                const CircleAvatar(
                  backgroundColor: Color(0xFF9B9B9B),
                  radius: 4,
                ),
                const CircleAvatar(
                  backgroundColor: Color(0xFF717373),
                  radius: 4,
                ),
                const CircleAvatar(
                  backgroundColor: Color(0xFF9B9B9B),
                  radius: 4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StopTimes extends StatelessWidget {
  const _StopTimes({
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
