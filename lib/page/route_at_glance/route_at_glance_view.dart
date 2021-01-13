import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong/latlong.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../core/cubit/route/route_cubit.dart';
import '../../widget/general/gm_button_loading.dart';
import '../../widget/general/gm_scaffold.dart';
import '../stop_list/stop_list_page.dart';
import 'widget/basic_route_info.dart';

class RouteAtGlanceView extends StatelessWidget {
  const RouteAtGlanceView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<RouteCubit>();
    return BlocConsumer<RouteCubit, RouteState>(
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
      builder: (_, state) => GMScaffold(
        title: 'WELCOME ${cubit.driverName.toUpperCase()}',
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: const Icon(
            MdiIcons.accountCircle,
            size: 36,
          ),
        ),
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
        mainActionButton: FloatingActionButton(
          onPressed: () => _onPressedButton(cubit, context),
          child: _getMainButtonIcon(cubit),
          backgroundColor: const Color(0xFF3AA348),
        ),
        mainActionButtonLabel: _getMainButtonLabel(cubit),
      ),
    );
  }

  Future<void> _onPressedButton(RouteCubit cubit, BuildContext context) async {
    final state = cubit.state;
    final route = cubit.route;
    if (state is StartingRoute) {
      return null;
    } else if (state is RouteStartedSuccess) {
      await cubit.departOrigin();
    } else if (route.status == 'NOT_STARTED') {
      await cubit.startRoute();
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: cubit,
            child: const StopListPage(),
          ),
        ),
      );
    }
  }

  Widget _getMainButtonIcon(RouteCubit cubit) {
    final state = cubit.state;
    final route = cubit.route;
    if (state is StartingRoute) {
      return const GMButtonLoading();
    } else if (state is RouteStartedSuccess) {
      return SvgPicture.asset('assets/icons/driving.svg');
    } else if (route.status == 'NOT_STARTED') {
      return SvgPicture.asset('assets/icons/truck-front.svg');
    } else {
      return SvgPicture.asset('assets/icons/location.svg');
    }
  }

  String _getMainButtonLabel(RouteCubit cubit) {
    final state = cubit.state;
    final route = cubit.route;
    if (state is RouteStartedSuccess) {
      return 'LEAVE WAREHOUSE';
    } else if (route.status == 'NOT_STARTED') {
      return 'START ROUTE';
    } else {
      return 'STOP LIST';
    }
  }
}
