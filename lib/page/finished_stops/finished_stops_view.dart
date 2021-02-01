import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/cubit/route/route_cubit.dart';
import '../../core/entity/model/models.dart';
import '../../core/extension/i18n_cubit_extension.dart';
import '../../widget/general/gm_scaffold.dart';
import 'widget/finished_stop_list_tile.dart';

class FinishedStopsView extends StatelessWidget {
  const FinishedStopsView({
    Key key,
    @required this.stops,
  }) : super(key: key);

  final List<StopModel> stops;

  @override
  Widget build(BuildContext context) {
    return GMScaffold(
      title: context.getTextUppercase('stop.list'),
      body: ListView.builder(
        itemBuilder: (_, i) => FinishedStopListTile(stops[i]),
        itemCount: stops.length,
      ),
      mainButtonAction: () => context.read<RouteCubit>().arriveWarehouse(),
      mainButtonIcon: SvgPicture.asset('assets/icons/sidetruck.svg'),
      mainButtonLabel: context.getTextUppercase('driver.arrivedc'),
    );
  }
}
