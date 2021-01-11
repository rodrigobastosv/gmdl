import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/cubit/cubits.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../core/entity/model/models.dart';

class StopListTile extends StatelessWidget {
  StopListTile(this.stop);

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
                  const Text(
                    //stop.plannedArrival.substring(0, 6),
                    '01: 04 PM',
                    style: TextStyle(
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
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(
                    MdiIcons.directionsFork,
                    color: Color(0xFF464646),
                  ),
                  const SizedBox(width: 8),
                  const Text('Directions'),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      MdiIcons.truckDelivery,
                      color: Color(0xFF464646),
                    ),
                    onPressed: () =>
                        context.read<RouteCubit>().arriveStop(stop),
                  ),
                  const SizedBox(width: 8),
                  const Text('Arrival'),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
