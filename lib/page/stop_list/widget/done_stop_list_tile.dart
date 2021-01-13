import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/cubit/cubits.dart';

import '../../../core/entity/model/models.dart';
import '../../../core/utils/date_utils.dart';
import '../../../widget/stop/stop_sizes.dart';
import '../../pages.dart';

class DoneStopListTile extends StatelessWidget {
  DoneStopListTile(this.stop);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<RouteCubit>(),
                    child: StopPage(stop: stop),
                  ),
                ),
              );
            },
            child: Row(
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
                      StopSizes(stop: stop),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
