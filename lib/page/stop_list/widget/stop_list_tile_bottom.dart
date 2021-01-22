import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/cubit/cubits.dart';
import '../../../core/entity/model/models.dart';
import '../../../core/extension/i18n_cubit_extension.dart';

class StopListTileBottom extends StatelessWidget {
  const StopListTileBottom({
    Key key,
    this.stop,
  }) : super(key: key);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
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
                  primary: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                icon: SvgPicture.asset('assets/icons/directions.svg',
                    color: Colors.black),
                onPressed: () {},
              ),
              if (stop.hasNotBeenArrived)
                TextButton.icon(
                  label: Text(
                    context.getText('route.inlinemenu.arrival'),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    textStyle: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  icon: SvgPicture.asset('assets/icons/arrival.svg',
                      color: Colors.black),
                  onPressed: () => context.read<RouteCubit>().arriveStop(stop),
                ),
            ],
          ),
        ),
        const Divider(thickness: 2),
      ],
    );
  }
}
