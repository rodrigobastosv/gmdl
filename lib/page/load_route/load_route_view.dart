import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../route_at_glance/route_at_glance_page.dart';
import '../../core/cubit/cubits.dart';
import '../../widget/gm_loading.dart';

class LoadRouteView extends StatelessWidget {
  const LoadRouteView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24242A),
      body: BlocConsumer<LoadRouteCubit, LoadRouteState>(
        listener: (_, state) {
          if (state is RouteLoadedSuccess) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RouteAtGlancePage(
                  route: state.route,
                ),
              ),
            );
          }
        },
        builder: (_, state) {
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
        },
      ),
    );
  }
}
