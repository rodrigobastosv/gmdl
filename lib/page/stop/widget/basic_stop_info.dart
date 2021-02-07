import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/stop/stop_cubit.dart';
import '../../../core/entity/model/models.dart';
import '../../../core/utils/time_utils.dart';
import '../../../core/utils/utils.dart';
import '../../../widget/general/gm_timer.dart';

class BasicStopInfo extends StatelessWidget {
  const BasicStopInfo({
    Key key,
    @required this.stop,
  }) : super(key: key);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF24242A),
      height: 76,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              children: [
                (stop.isPending && stop.hasBeenArrived)
                    ? BlocBuilder<StopCubit, StopState>(
                        buildWhen: (prevState, state) =>
                            state is ServiceTimeUpdated,
                        builder: (_, state) => GMTimer(
                          // TODO remove this hard code
                          expirationTime: const Duration(
                            minutes: 1,
                          ),
                          timeInSeconds:
                              context.read<StopCubit>().serviceTimeInSeconds,
                        ),
                      )
                    : Text(
                        getHourAndMinuteFromSeconds(
                          getStopServiceTimeInSeconds(stop),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                const SizedBox(height: 6),
                const Text(
                  '15:00',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                    getLocationInfo(stop),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                    stop.location?.addressLine1 ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFCCCCCC),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
