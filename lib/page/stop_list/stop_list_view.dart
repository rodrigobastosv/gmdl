import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import 'widget/done_stop_tab_view.dart';
import 'widget/done_stops_tab.dart';
import 'widget/pending_stops_tab.dart';
import 'widget/pending_stops_tab_view.dart';

class StopListView extends StatelessWidget {
  const StopListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<RouteCubit>();
    final stops = cubit.route.stops;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'STOP LIST',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<RouteCubit, RouteState>(
          builder: (_, state) => Column(
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
                    PendingStopsTab(stops: stops),
                    DoneStopsTab(stops: stops),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    PendingStopsTabView(stops: stops),
                    DoneStopsTabView(stops: stops),
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
