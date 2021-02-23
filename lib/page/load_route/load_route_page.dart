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
      backgroundColor: Theme.of(context).backgroundColor,
      withAppBar: false,
      body: BlocConsumer<LoadRouteCubit, LoadRouteState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }

  void _listener(BuildContext context, LoadRouteState state) {
    if (state is LoadRouteSuccess) {
      Navigator.of(context).pushReplacementNamed(
        ROUTE_AT_GLANCE_PAGE,
        arguments: state.route,
      );
    } else if (state is LoadRouteFailure) {
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
          if (state is LoadRouteLoad)
            Text(
              state.info,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.white,
                  ),
            ),
        ],
      ),
    );
  }
}
