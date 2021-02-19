import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/cubits.dart';
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
      color: Theme.of(context).backgroundColor,
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
                            state is StopServiceTimeUpdate,
                        builder: (_, state) => GMTimer(
                          expirationTime: Duration(
                            minutes: getStopPlannedServiceTimeInSeconds(stop),
                          ),
                          timeInSeconds:
                              context.read<StopCubit>().serviceTimeInSeconds,
                        ),
                      )
                    : Text(
                        getHourAndMinuteFromSeconds(
                          getStopServiceTimeInSeconds(stop),
                        ),
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.white,
                            ),
                      ),
                const SizedBox(height: 6),
                Text(
                  getHourAndMinuteFromSeconds(
                    getStopPlannedServiceTimeInSeconds(stop),
                  ),
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
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
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
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
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 12,
                          color: const Color(0xFFCCCCCC),
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
