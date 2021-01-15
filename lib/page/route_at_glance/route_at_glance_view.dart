import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../core/cubit/route/route_cubit.dart';
import '../../core/entity/enum/enums.dart';
import '../../widget/general/gm_button_loading.dart';
import '../../widget/general/gm_scaffold.dart';
import '../stop_list/stop_list_page.dart';
import 'widget/basic_route_info.dart';
import 'widget/route_map.dart';

class RouteAtGlanceView extends StatelessWidget {
  const RouteAtGlanceView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RouteCubit, RouteState>(
      listener: _listener,
      builder: _builder,
    );
  }

  void _listener(BuildContext context, RouteState state) {
    if (state is DepartOriginSuccess) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: context.read<RouteCubit>(),
            child: const StopListPage(),
          ),
        ),
      );
    }
  }

  Widget _builder(BuildContext context, RouteState state) {
    final cubit = context.watch<RouteCubit>();
    return GMScaffold(
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
            route: cubit.route,
          ),
          Expanded(
            child: RouteMap(route: cubit.route),
          ),
        ],
      ),
      mainActionButton: FloatingActionButton(
        onPressed: () => _onPressedButton(cubit, context),
        child: _getMainButtonIcon(cubit),
        backgroundColor: const Color(0xFF3AA348),
      ),
      mainActionButtonLabel: _getMainButtonLabel(cubit),
    );
  }

  Future<void> _onPressedButton(RouteCubit cubit, BuildContext context) async {
    final state = cubit.state;
    final route = cubit.route;
    if (state is StartingRoute) {
      return null;
    } else if (route.status == RouteStatus.STARTED) {
      await cubit.departOrigin();
    } else if (route.status == RouteStatus.NOT_STARTED) {
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
    } else if (route.status == RouteStatus.STARTED) {
      return SvgPicture.asset('assets/icons/driving.svg');
    } else if (route.status == RouteStatus.NOT_STARTED) {
      return SvgPicture.asset('assets/icons/truck-front.svg');
    } else {
      return SvgPicture.asset('assets/icons/location.svg');
    }
  }

  String _getMainButtonLabel(RouteCubit cubit) {
    final route = cubit.route;
    if (route.status == RouteStatus.STARTED) {
      return 'LEAVE WAREHOUSE';
    } else if (route.status == RouteStatus.NOT_STARTED) {
      return 'START ROUTE';
    } else {
      return 'STOP LIST';
    }
  }
}
