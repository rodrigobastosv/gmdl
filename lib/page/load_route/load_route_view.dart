import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../widget/general/gm_loading.dart';
import '../../widget/general/gm_scaffold.dart';
import '../route_at_glance/route_at_glance_page.dart';

class LoadRouteView extends StatelessWidget {
  const LoadRouteView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GMScaffold(
      backgroundColor: const Color(0xFF24242A),
      withAppBar: false,
      withNavigationBar: false,
      body: BlocConsumer<LoadRouteCubit, LoadRouteState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }

  void _listener(BuildContext context, LoadRouteState state) {
    if (state is RouteLoadedSuccess) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => RouteAtGlancePage(
            route: state.route,
          ),
        ),
      );
    }
  }

  Widget _builder(BuildContext context, LoadRouteState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: GMLoading(),
          ),
          const SizedBox(height: 12),
          if (state is LoadingInfo)
            Text(
              state.info,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
