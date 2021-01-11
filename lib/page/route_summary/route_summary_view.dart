import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/cubit/cubits.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RouteSummaryView extends StatelessWidget {
  const RouteSummaryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'ROUTE SUMMARY',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<RouteCubit, RouteState>(
        listener: (_, state) {
          if (state is RouteCompletedSuccess) {
            print('logout!!!');
          }
        },
        builder: (_, state) => Column(
          children: [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<RouteCubit>().completeRoute(),
        tooltip: 'COMPLETE ROUTE',
        child: const Icon(
          MdiIcons.drone,
          size: 32,
        ),
        backgroundColor: const Color(0xFF3AA348),
      ),
    );
  }
}
