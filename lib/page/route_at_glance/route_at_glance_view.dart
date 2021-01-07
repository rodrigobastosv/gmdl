import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/cubit/route/route_cubit.dart';

class RouteAtGlanceView extends StatelessWidget {
  const RouteAtGlanceView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RouteCubit, RouteState>(
        builder: (_, state) => Container(),
      ),
    );
  }
}
