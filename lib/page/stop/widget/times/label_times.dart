import 'package:flutter/material.dart';

import 'package:flutter_dash/flutter_dash.dart';

import '../../../../core/entity/model/models.dart';
import '../../../../core/extension/extensions.dart';

class LabelTimes extends StatelessWidget {
  const LabelTimes({
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
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: const Color(0xFF9B9B9B),
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
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: const Color(0xFF717373),
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            '${context.getText('details.label.planned')}',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: const Color(0xFF9B9B9B),
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
        ? '''${context.getText('details.label.arrival')} ${context.getText('route.tab.done')}'''
        : '''${context.getText('details.label.arrival')} ${context.getText('details.label.projected')}''';
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText1.copyWith(
            color: stopHasBeenArrived
                ? const Color(0xFF75B800)
                : const Color(0xFF717373),
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
