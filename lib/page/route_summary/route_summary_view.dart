import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../core/cubit/cubits.dart';
import '../../core/extension/i18n_cubit_extension.dart';
import '../../widget/general/gm_button_loading.dart';
import '../../widget/general/gm_scaffold.dart';
import '../initial_settings/initial_settings_page.dart';
import '../pages_names.dart';
import 'widget/basic_route_summary_info.dart';
import 'widget/route_summary_header_info.dart';

class RouteSummaryView extends StatelessWidget {
  const RouteSummaryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RouteCubit, RouteState>(
      listener: _listener,
      builder: _builder,
    );
  }

  void _listener(BuildContext context, RouteState state) {
    if (state is RouteCompletedSuccess) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const InitialSettingsPage(),
            settings: const RouteSettings(name: INITIAL_SETTINGS_PAGE),
          ),
          (_) => false);
    }
  }

  Widget _builder(BuildContext context, RouteState state) {
    final cubit = context.watch<RouteCubit>();
    final route = cubit.route;
    return GMScaffold(
      title: context.getTextUppercase('driver.goodjob.beforevocative'),
      mainActionButton: FloatingActionButton(
        onPressed: cubit.completeRoute,
        child: _getMainButtonIcon(cubit),
        backgroundColor: const Color(0xFF3AA348),
      ),
      mainActionButtonLabel: context.getTextUppercase('status.complete'),
      body: Column(
        children: [
          Container(
            height: 100,
            color: const Color(0xFF181818),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                children: [
                  RouteSummaryHeaderInfo(route: route),
                  const SizedBox(height: 8),
                  BasicRouteSummaryInfo(route: route),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    MdiIcons.notebookCheckOutline,
                    size: 38,
                    color: Color(0xFF9b9b9b),
                  ),
                  Text(
                    context.getTextUppercase('loader.nothing.found'),
                    style: const TextStyle(
                      color: Color(0xFF9b9b9b),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getMainButtonIcon(RouteCubit cubit) {
    final state = cubit.state;
    if (state is CompletingRoute || state is RouteCompletedSuccess) {
      return const GMButtonLoading();
    } else {
      return SvgPicture.asset('assets/icons/end-route.svg');
    }
  }
}
