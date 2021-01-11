import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/cubit/route/route_cubit.dart';
import 'finished_stops_view.dart';

class FinishedStopsPage extends StatelessWidget {
  const FinishedStopsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<RouteCubit>();
    return BlocProvider.value(
      value: cubit,
      child: FinishedStopsView(
        stops: cubit.route.stops,
      ),
    );
  }
}
