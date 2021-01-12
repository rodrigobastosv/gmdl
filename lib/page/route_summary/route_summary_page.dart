import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import 'route_summary_view.dart';

class RouteSummaryPage extends StatelessWidget {
  const RouteSummaryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.watch<RouteCubit>(),
      child: const RouteSummaryView(),
    );
  }
}
