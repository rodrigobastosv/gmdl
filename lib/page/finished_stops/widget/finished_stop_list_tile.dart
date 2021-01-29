import 'package:flutter/material.dart';

import '../../../core/entity/model/models.dart';
import '../../../core/utils/utils.dart';

class FinishedStopListTile extends StatelessWidget {
  FinishedStopListTile(this.stop);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getStopWidget(
                isRouteFinished: true,
                stop: stop,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${stop.location.key} -  ${stop.location.description}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(stop.location.addressLine1 ?? ''),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
