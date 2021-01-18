import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/cubit/cubits.dart';
import '../../../core/entity/model/models.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/utils.dart';
import '../../../widget/stop/stop_sizes.dart';
import '../../pages.dart';
import 'stop_list_tile_bottom.dart';

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
                    Stack(
                      children: [
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
                        _getStopStatusIcon(stop),
                      ],
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
          ),
          if (isPendingStop(stop)) StopListTileBottom(stop: stop),
        ],
      ),
    );
  }

  Widget _getStopStatusIcon(StopModel stop) {
    if (stop.isCloned) {
      return Positioned(
        bottom: -2,
        left: -2,
        child: SvgPicture.asset(
          'assets/icons/stop-cloned.svg',
          height: 18,
          width: 18,
        ),
      );
    } else if (stop.isCanceled) {
      return Positioned(
        bottom: -2,
        left: -2,
        child: SvgPicture.asset(
          'assets/icons/canceled.svg',
          height: 18,
          width: 18,
        ),
      );
    } else if (stop.isUndeliverable) {
      return Positioned(
        bottom: -2,
        left: -2,
        child: SvgPicture.asset(
          'assets/icons/stop-undelivered.svg',
          height: 18,
          width: 18,
        ),
      );
    }
    return const SizedBox();
  }
}
