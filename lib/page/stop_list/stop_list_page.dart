import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../core/extension/extensions.dart';
import '../../core/extension/i18n_cubit_extension.dart';
import '../../core/route/route.dart';
import '../../core/utils/utils.dart';
import '../../widget/general/gm_scaffold.dart';
import '../../widget/general/gm_search_text_field.dart';
import '../../widget/menu_items/menu_items.dart';
import '../stop/stop_page_arguments.dart';
import 'widget/done_stop_tab_view.dart';
import 'widget/done_stops_tab.dart';
import 'widget/no_stop_found.dart';
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
          child: BlocBuilder<StopSearchCubit, StopSearchState>(
            builder: (_, state) {
              final term = state is SearchTermChanged ? state.searchTerm : '';
              final pendingStopsFiltered = filterStopsByTerm(
                pendingStops,
                term,
              );
              final doneStopsFiltered = filterStopsByTerm(
                doneStops,
                term,
              );
              return Column(
                children: [
                  GMSearchTextField(
                    initialValue: term,
                    onChanged:
                        context.read<StopSearchCubit>().onChangeSearchTerm,
                  ),
                  Container(
                    height: 38,
                    color: Colors.black,
                    child: TabBar(
                      key: UniqueKey(),
                      indicatorWeight: 3,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: const Color(0xFFE0E0E0),
                      indicatorColor: Theme.of(context).primaryColor,
                      tabs: [
                        PendingStopsTab(stops: pendingStopsFiltered),
                        if (doneStops.isNotEmpty)
                          DoneStopsTab(stops: doneStopsFiltered),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      key: UniqueKey(),
                      children: [
                        pendingStopsFiltered.isNotEmpty
                            ? PendingStopsTabView(
                                stops: pendingStopsFiltered,
                                isUsingPro: cubit.route.isUsingPro,
                              )
                            : const NoStopFound(),
                        if (doneStops.isNotEmpty)
                          doneStopsFiltered.isNotEmpty
                              ? DoneStopsTabView(stops: doneStopsFiltered)
                              : const NoStopFound(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        mainButtonLabel: context.getTextUppercase('driver.seeMap'),
        mainButtonIcon: const Icon(Icons.map),
        mainButtonAction: cubit.route.isUsingPro
            ? () => Navigator.of(context).pushNamed(
                  MAP_PAGE,
                  arguments: cubit,
                )
            : null,
        menuOptions: _getMenuOptions(context),
      ),
    );
  }

  void _listener(BuildContext context, RouteState state) {
    if (state is RouteArriveStopSuccess) {
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
    } else if (state is RouteArriveWarehouseSuccess) {
      Navigator.of(context).pushNamed(
        ROUTE_SUMMARY_PAGE,
        arguments: context.read<RouteCubit>(),
      );
    }
  }

  List<Widget> _getMenuOptions(BuildContext context) {
    return [
      const HosLunchMenuItem(),
    ];
  }
}
