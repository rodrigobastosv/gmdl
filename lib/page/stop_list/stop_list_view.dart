import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../core/selector/route_selectors.dart';
import '../../widget/general/gm_scaffold.dart';
import '../finished_stops/finished_stops_page.dart';
import '../pages.dart';
import '../stop/stop_page.dart';
import 'widget/done_stop_tab_view.dart';
import 'widget/done_stops_tab.dart';
import 'widget/pending_stops_tab.dart';
import 'widget/pending_stops_tab_view.dart';

class StopListView extends StatelessWidget {
  const StopListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<RouteCubit>();
    final pendingStops = getPendingStops(cubit.route);
    final doneStops = getDoneStops(cubit.route);
    return DefaultTabController(
      length: doneStops.isNotEmpty ? 2 : 1,
      child: GMScaffold(
        title: 'STOP LIST',
        body: BlocListener<RouteCubit, RouteState>(
          listener: (_, state) {
            if (state is ArrivedStopSuccess) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<RouteCubit>(),
                    child: StopPage(
                      stop: state.stop,
                    ),
                  ),
                ),
              );
            } else if (state is RouteHasNoPendingStops) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<RouteCubit>(),
                    child: const FinishedStopsPage(),
                  ),
                ),
              );
            } else if (state is ArrivedWarehouseSuccess) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<RouteCubit>(),
                    child: const RouteSummaryPage(),
                  ),
                ),
              );
            } else if (state is RouteCompletedSuccess) {}
          },
          child: Column(
            children: [
              Container(
                height: 38,
                color: Colors.black,
                child: TabBar(
                  indicatorWeight: 3,
                  labelColor: const Color(0xFFB0D25A),
                  unselectedLabelColor: const Color(0xFFE0E0E0),
                  indicatorColor: const Color(0xFFB0D25A),
                  tabs: [
                    PendingStopsTab(stops: pendingStops),
                    if (doneStops.isNotEmpty) DoneStopsTab(stops: doneStops),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    PendingStopsTabView(stops: pendingStops),
                    if (doneStops.isNotEmpty)
                      DoneStopsTabView(stops: doneStops),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
