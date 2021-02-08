import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../core/extension/i18n_cubit_extension.dart';
import '../../core/route/route.dart';
import '../../core/selector/route_selectors.dart';
import '../../widget/general/gm_scaffold.dart';
import '../stop/stop_page_arguments.dart';
import 'widget/done_stop_tab_view.dart';
import 'widget/done_stops_tab.dart';
import 'widget/pending_stops_tab.dart';
import 'widget/pending_stops_tab_view.dart';

class StopListPage extends StatelessWidget {
  const StopListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<RouteCubit>();
    final pendingStops = getPendingStops(cubit.route);
    final doneStops = getDoneStops(cubit.route);
    return DefaultTabController(
      length: doneStops.isNotEmpty ? 2 : 1,
      child: GMScaffold(
        title: context.getTextUppercase('stop.list'),
        body: BlocListener<RouteCubit, RouteState>(
          listener: _listener,
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
                    PendingStopsTabView(
                      stops: pendingStops,
                      isUsingPro: cubit.route.isUsingPro,
                    ),
                    if (doneStops.isNotEmpty)
                      DoneStopsTabView(stops: doneStops),
                  ],
                ),
              ),
            ],
          ),
        ),
        mainButtonLabel: context.getTextUppercase('driver.seeMap'),
        mainButtonIcon: const Icon(Icons.map),
        mainButtonAction: () => Navigator.of(context).pushNamed(
          MAP_PAGE,
          arguments: cubit,
        ),
      ),
    );
  }

  void _listener(BuildContext context, RouteState state) {
    if (state is ArrivedStopSuccess) {
      Navigator.of(context).pushNamed(
        STOP_PAGE,
        arguments: StopPageArguments(
          stop: state.stop,
          routeCubit: context.read<RouteCubit>(),
        ),
      );
    } else if (state is RouteHasNoPendingStops) {
      Navigator.of(context).pushNamed(
        FINISHED_STOPS_PAGE,
        arguments: context.read<RouteCubit>(),
      );
    } else if (state is ArrivedWarehouseSuccess) {
      Navigator.of(context).pushNamed(
        ROUTE_SUMMARY_PAGE,
        arguments: context.read<RouteCubit>(),
      );
    }
  }
}
