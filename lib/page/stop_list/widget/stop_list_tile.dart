import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../stop/stop_page_arguments.dart';

import '../../../core/cubit/cubits.dart';
import '../../../core/entity/model/models.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/utils.dart';
import '../../../widget/stop/stop_sizes.dart';
import '../../pages.dart';
import 'stop_icon.dart';
import 'stop_list_tile_bottom.dart';
import 'stop_list_tile_header.dart';

class StopListTile extends StatelessWidget {
  StopListTile({
    this.stop,
    this.isUsingPro = false,
    this.isNextStopSuggested = false,
    this.isBeginNextStops = false,
  });

  final StopModel stop;
  final bool isUsingPro;
  final bool isNextStopSuggested;
  final bool isBeginNextStops;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getStopTileHeaderIfAny(context),
        Container(
          color: _getColor(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      StopPage.routeName,
                      arguments: StopPageArguments(
                        stop: stop,
                        routeCubit: context.read<RouteCubit>(),
                      ),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          StopIcon(
                            stop: stop,
                            iconColor: _getStopIconColor(),
                            textColor: _getStopIconTextColor(),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            getBasicDateHourMinute(stop.plannedArrival),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _getStopTimeTextColor(),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 100,
                              child: Text(
                                '''${stop.location.key} -  ${stop.location.description}''',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _getTextColor(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 100,
                              child: Text(
                                stop.location.addressLine1 ?? '',
                                maxLines: 2,
                                style: TextStyle(
                                  color: _getTextColor(context),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            StopSizes(
                              stop: stop,
                              iconColor: const Color(0xFFB0D25A),
                              textColor: _getTextColor(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (stop.isPending)
                  StopListTileBottom(
                    stop: stop,
                    textColor: _getTextColor(context),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _getStopTileHeaderIfAny(BuildContext context) {
    if (isUsingPro) {
      if (isNextStopSuggested) {
        return StopListTileHeader(
          stop.isInProgress
              ? 'route.stopInProgrees'
              : 'driver.nextStopSuggested',
        );
      } else if (isBeginNextStops) {
        return const StopListTileHeader(
          'driver.nextStops',
        );
      }
      return const SizedBox();
    }
    return const SizedBox();
  }

  Color _getStopIconColor() {
    if (isUsingPro && isNextStopSuggested) {
      return Colors.white;
    }
    return const Color(0xFF464646);
  }

  Color _getStopIconTextColor() {
    if (isUsingPro && isNextStopSuggested) {
      return const Color(0xFF3AA348);
    }
    return Colors.white;
  }

  Color _getColor(BuildContext context) {
    if (isUsingPro && isNextStopSuggested) {
      return const Color(0xFF3AA348);
    }
    return Theme.of(context).scaffoldBackgroundColor;
  }

  Color _getTextColor(BuildContext context) {
    if (isUsingPro && isNextStopSuggested) {
      return Colors.white;
    }
    return Theme.of(context).textTheme.bodyText1.color;
  }

  Color _getStopTimeTextColor() {
    if (isUsingPro && isNextStopSuggested) {
      return Colors.white;
    }
    return const Color(0xFF464646);
  }
}
