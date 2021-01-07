import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../../core/cubit/route/route_cubit.dart';
import '../../widget/gm_button_loading.dart';
import '../../widget/gm_menu_drawer.dart';
import 'widget/basic_route_info.dart';

class RouteAtGlanceView extends StatelessWidget {
  const RouteAtGlanceView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<RouteCubit>();
    return SafeArea(
      child: BlocBuilder<RouteCubit, RouteState>(
        builder: (_, state) => Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: const Icon(
                    Ionicons.md_person,
                    size: 36,
                  ),
                ),
                const SizedBox(width: 60),
                Text(
                  'WELCOME ${cubit.driverName.toUpperCase()}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            centerTitle: true,
          ),
          endDrawer: const GMMenuDrawer(),
          body: Column(
            children: <Widget>[
              BasicRouteInfo(
                route: context.read<RouteCubit>().route,
              ),
              Expanded(
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(
                      cubit.route.origLatitude,
                      cubit.route.origLongitude,
                    ),
                    zoom: 13,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _onPressedButton(cubit),
            tooltip: state is RouteStartedSuccess
                ? 'LEAVE WAREHOUSE'
                : 'START ROUTE',
            child: _getMainIcon(state),
            backgroundColor: const Color(0xFF3AA348),
          ),
        ),
      ),
    );
  }

  void _onPressedButton(RouteCubit cubit) async {
    if (cubit.state is RouteInitial || cubit.state is RouteStartFailed) {
      await cubit.startRoute();
    } else if (cubit.state is RouteStartedSuccess) {
      return;
    } else {
      return;
    }
  }

  Widget _getMainIcon(RouteState state) {
    if (state is StartingRoute) {
      return const GMButtonLoading();
    } else if (state is RouteStartedSuccess) {
      return const Icon(
        MaterialCommunityIcons.ab_testing,
        size: 32,
      );
    } else {
      return const Icon(
        MaterialCommunityIcons.truck,
        size: 32,
      );
    }
  }
}
