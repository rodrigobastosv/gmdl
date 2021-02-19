import 'package:flutter/material.dart';

import '../../../../core/entity/model/stop_model.dart';
import '../../../../core/extension/extensions.dart';
import 'dot_times.dart';
import 'label_times.dart';
import 'stop_times.dart';

class TimesCard extends StatelessWidget {
  const TimesCard({
    Key key,
    this.stop,
  })  : assert(stop != null),
        super(key: key);

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
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Container(
            height: 140,
            child: Row(
              children: <Widget>[
                LabelTimes(stop: stop),
                DotTimes(stop: stop),
                StopTimes(stop: stop),
              ],
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
