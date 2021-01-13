import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/cubit/route/route_cubit.dart';
import '../../core/entity/model/models.dart';
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
      title: 'STOP LIST',
      body: ListView.builder(
        itemBuilder: (_, i) => FinishedStopListTile(stops[i]),
        itemCount: stops.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<RouteCubit>().arriveWarehouse(),
        tooltip: 'ARRIVE AT THE WAREHOUSE',
        child: SvgPicture.asset('assets/icons/sidetruck.svg'),
        backgroundColor: const Color(0xFF3AA348),
      ),
    );
  }
}
