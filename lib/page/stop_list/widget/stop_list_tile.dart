import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/cubits.dart';
import '../../../core/entity/model/models.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/utils.dart';
import '../../../widget/stop/stop_location_info.dart';
import '../../../widget/stop/stop_sizes.dart';
import '../../stop/stop_page_arguments.dart';
import 'stop_icon.dart';
import 'stop_list_tile_bottom.dart';
import 'stop_list_tile_header.dart';

class StopListTile extends StatelessWidget {
  StopListTile({
    Key key,
    @required this.stop,
    this.isUsingPro = false,
    this.isNextStopSuggested = false,
    this.isBeginNextStops = false,
    this.headerBackgroundColor,
    this.headerTextColor,
  })  : assert(stop != null),
        super(key: key);

  final StopModel stop;
  final bool isUsingPro;
  final bool isNextStopSuggested;
  final bool isBeginNextStops;
  final Color headerBackgroundColor;
  final Color headerTextColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getStopTileHeaderIfAny(context),
        Container(
          color: _getColor(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      STOP_PAGE,
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
                            textColor: _getColor(),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            getBasicDateHourMinute(stop.plannedArrival),
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
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
                            StopLocationInfo(
                              stop: stop,
                              textColor: _getTextColor(context),
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
                    isUsingPro: isUsingPro,
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
          backgroundColor: headerBackgroundColor ??
              Theme.of(context).scaffoldBackgroundColor,
          textColor:
              headerTextColor ?? Theme.of(context).textTheme.bodyText2.color,
        );
      } else if (isBeginNextStops) {
        return StopListTileHeader(
          'driver.nextStops',
          backgroundColor: headerBackgroundColor ??
              Theme.of(context).scaffoldBackgroundColor,
          textColor:
              headerTextColor ?? Theme.of(context).textTheme.bodyText2.color,
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

  Color _getColor() {
    if (isUsingPro && isNextStopSuggested) {
      return const Color(0xFF3AA348);
    }
    return Colors.white;
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
