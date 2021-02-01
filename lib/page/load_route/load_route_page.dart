import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../core/extension/extensions.dart';
import '../../core/route/route.dart';
import '../../widget/alert/notification.dart';
import '../../widget/general/gm_loading.dart';
import '../../widget/general/gm_scaffold.dart';

class LoadRoutePage extends StatelessWidget {
  const LoadRoutePage({Key key}) : super(key: key);

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
      Navigator.of(context).pushReplacementNamed(
        ROUTE_AT_GLANCE_PAGE,
        arguments: state.route,
      );
    } else if (state is RouteLoadFailed) {
      showErrorNotification(context, context.getText(state.errorMessage));
      Navigator.of(context).pop();
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
