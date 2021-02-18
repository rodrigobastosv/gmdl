import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../core/cubit/cubits.dart';
import '../../core/cubit/route/route_cubit.dart';
import '../../core/entity/enum/enums.dart';
import '../../core/extension/extensions.dart';
import '../../core/extension/i18n_cubit_extension.dart';
import '../../core/route/route.dart';
import '../../widget/alert/notification.dart';
import '../../widget/general/gm_button_loading.dart';
import '../../widget/general/gm_scaffold.dart';
import '../../widget/menu_items/menu_items.dart';
import 'widget/basic_route_info.dart';
import 'widget/route_at_glance_map.dart';

class RouteAtGlancePage extends StatelessWidget {
  const RouteAtGlancePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RouteCubit, RouteState>(
      listener: _listener,
      builder: _builder,
    );
  }

  void _listener(BuildContext context, RouteState state) {
    if (state is RouteDepartOriginSuccess) {
      Navigator.of(context).pushNamed(
        STOP_LIST_PAGE,
        arguments: context.read<RouteCubit>(),
      );
    } else if (state is RouteStartFailed) {
      showErrorNotification(context, state.errorMessage);
    }
  }

  Widget _builder(BuildContext context, RouteState state) {
    final cubit = context.watch<RouteCubit>();
    return GMScaffold(
      title:
          '''${context.getTextUppercase('driver.welcome')} ${cubit.driverName.toUpperCase()}''',
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
            child: RouteAtGlanceMap(routeCubit: cubit),
          ),
        ],
      ),
      mainButtonAction: () => _onPressedButton(cubit, context),
      mainButtonIcon: _getMainButtonIcon(cubit),
      mainButtonLabel: _getMainButtonLabel(context, cubit),
      menuOptions: _getMenuOptions(context),
    );
  }

  Future<void> _onPressedButton(RouteCubit cubit, BuildContext context) async {
    final state = cubit.state;
    final route = cubit.route;
    if (state is RouteStartLoad) {
      return null;
    } else if (route.status == RouteStatus.STARTED) {
      await cubit.departOrigin();
    } else if (route.status == RouteStatus.NOT_STARTED) {
      await cubit.startRoute();
    } else {
      Navigator.of(context).pushNamed(
        STOP_LIST_PAGE,
        arguments: context.read<RouteCubit>(),
      );
    }
  }

  Widget _getMainButtonIcon(RouteCubit cubit) {
    final state = cubit.state;
    final route = cubit.route;
    if (state is RouteStartLoad ||
        state is RouteDepartOriginLoad ||
        state is RouteDepartOriginSuccess) {
      return const GMButtonLoading();
    } else if (route.status == RouteStatus.STARTED) {
      return SvgPicture.asset('assets/icons/driving.svg');
    } else if (route.status == RouteStatus.NOT_STARTED) {
      return SvgPicture.asset('assets/icons/truck-front.svg');
    } else {
      return SvgPicture.asset('assets/icons/location.svg');
    }
  }

  String _getMainButtonLabel(BuildContext context, RouteCubit cubit) {
    final route = cubit.route;
    if (route.status == RouteStatus.STARTED) {
      return context.getTextUppercase('driver.leavedc');
    } else if (route.status == RouteStatus.NOT_STARTED) {
      return context.getTextUppercase('equipment.button.start');
    } else {
      return context.getTextUppercase('stop.list');
    }
  }

  List<Widget> _getMenuOptions(BuildContext context) {
    return [
      const HosLunchMenuItem(),
    ];
  }
}
