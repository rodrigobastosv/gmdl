import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../core/cubit/route/route_cubit.dart';
import '../../widget/gm_button_loading.dart';
import '../../widget/gm_menu_drawer.dart';
import '../stop_list/stop_list_page.dart';
import 'widget/basic_route_info.dart';

class RouteAtGlanceView extends StatelessWidget {
  const RouteAtGlanceView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<RouteCubit>();
    return SafeArea(
      child: BlocConsumer<RouteCubit, RouteState>(
        listener: (_, state) {
          if (state is DepartOriginSuccess) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: cubit,
                  child: const StopListPage(),
                ),
              ),
            );
          }
        },
        builder: (_, state) => Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            automaticallyImplyLeading: false,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: const Icon(
                MdiIcons.accountCircle,
                size: 36,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
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

  Future<void> _onPressedButton(RouteCubit cubit) async {
    if (cubit.state is RouteInitial || cubit.state is RouteStartFailed) {
      await cubit.startRoute();
    } else if (cubit.state is RouteStartedSuccess) {
      await cubit.departOrigin();
    } else {
      return;
    }
  }

  Widget _getMainIcon(RouteState state) {
    if (state is StartingRoute) {
      return const GMButtonLoading();
    } else if (state is RouteStartedSuccess) {
      return const Icon(
        MdiIcons.truckFastOutline,
        size: 32,
      );
    } else {
      return const Icon(
        MdiIcons.truckCheckOutline,
        size: 32,
      );
    }
  }
}
