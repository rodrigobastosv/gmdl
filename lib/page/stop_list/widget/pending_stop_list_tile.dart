import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../core/cubit/cubits.dart';
import '../../../core/entity/model/models.dart';
import '../../../core/utils/date_utils.dart';
import '../../../widget/stop/stop_sizes.dart';

class PendingStopListTile extends StatelessWidget {
  PendingStopListTile(this.stop);

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
              Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: const Color(0xFF464646),
                    child: Text(
                      stop.plannedSequenceNum.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    getBasicDateHourMinute(stop.plannedArrival),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF464646),
                    ),
                  ),
                ],
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
                    Text(stop.location.addressLine1),
                    const SizedBox(height: 8),
                    StopSizes(stop: stop),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          Container(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton.icon(
                  label: const Text('Directions'),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    textStyle: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  icon: const Icon(
                    MdiIcons.directionsFork,
                    color: Color(0xFF464646),
                    size: 16,
                  ),
                  onPressed: () {},
                ),
                TextButton.icon(
                  label: const Text('Arrival'),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    textStyle: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  icon: const Icon(
                    MdiIcons.truckDelivery,
                    color: Color(0xFF464646),
                    size: 16,
                  ),
                  onPressed: () => context.read<RouteCubit>().arriveStop(stop),
                ),
              ],
            ),
          ),
          const Divider(thickness: 2),
        ],
      ),
    );
  }
}
