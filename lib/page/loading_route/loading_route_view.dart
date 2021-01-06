import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../widget/gm_loading.dart';

class LoadingRouteView extends StatelessWidget {
  const LoadingRouteView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24242A),
      body: BlocConsumer<RouteAtGlanceCubit, RouteAtGlanceState>(
        listener: (_, state) {},
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
