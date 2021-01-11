import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/cubit/route/route_cubit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../core/entity/model/models.dart';
import 'widget/finished_stop_list_tile.dart';

class FinishedStopsView extends StatelessWidget {
  const FinishedStopsView({
    Key key,
    @required this.stops,
  }) : super(key: key);

  final List<StopModel> stops;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'STOP LIST',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (_, i) => FinishedStopListTile(stops[i]),
        itemCount: stops.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<RouteCubit>().arriveWarehouse(),
        tooltip: 'ARRIVE AT THE WAREHOUSE',
        child: const Icon(
          MdiIcons.truck,
          size: 32,
        ),
        backgroundColor: const Color(0xFF3AA348),
      ),
    );
  }
}
