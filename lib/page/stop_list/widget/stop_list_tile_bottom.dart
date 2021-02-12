import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/cubit/cubits.dart';
import '../../../core/entity/model/models.dart';
import '../../../core/extension/extensions.dart';
import '../../../widget/general/gm_button_loading.dart';

class StopListTileBottom extends StatelessWidget {
  const StopListTileBottom({
    Key key,
    this.isUsingPro = false,
    @required this.stop,
    @required this.textColor,
  }) : super(key: key);

  final bool isUsingPro;
  final StopModel stop;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: Colors.grey),
        Container(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton.icon(
                label: Text(
                  context.getText('stopList.tabs.directions'),
                ),
                style: TextButton.styleFrom(
                  primary: textColor,
                  textStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                icon: SvgPicture.asset(
                  'assets/icons/directions.svg',
                  color: textColor,
                ),
                onPressed: () async =>
                    await context.read<RouteCubit>().launchMapForDirections(
                          latitude: stop.latitude,
                          longitude: stop.longitude,
                        ),
              ),
              if (stop.hasNotBeenArrived)
                BlocBuilder<RouteCubit, RouteState>(
                  builder: (_, state) => (state is RouteArriveStopLoad &&
                          state.stop == stop)
                      ? const GMButtonLoading()
                      : TextButton.icon(
                          label: Text(
                            context.getText('route.inlinemenu.arrival'),
                          ),
                          style: TextButton.styleFrom(
                            primary: textColor,
                            textStyle: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          icon: SvgPicture.asset(
                            'assets/icons/arrival.svg',
                            color: textColor,
                          ),
                          onPressed: () =>
                              context.read<RouteCubit>().arriveStop(
                                    stop: stop,
                                    actualArrival: DateTime.now().toUtcAsString,
                                  ),
                        ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
