import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/cubit/cubits.dart';
import '../../core/extension/extensions.dart';
import '../../core/extension/i18n_cubit_extension.dart';
import '../../core/route/route.dart';
import '../../widget/alert/notification.dart';
import '../../widget/general/gm_button_loading.dart';
import '../../widget/general/gm_scaffold.dart';
import '../../widget/menu_items/menu_items.dart';
import 'stop_page_arguments.dart';
import 'widget/basic_stop_info.dart';
import 'widget/times_card.dart';

class StopPage extends StatelessWidget {
  const StopPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<StopCubit>();
    return GMScaffold(
      backgroundColor: const Color(0xFFE3E3E3),
      body: BlocConsumer<StopCubit, StopState>(
        listener: _listener,
        builder: _builder,
      ),
      mainButtonAction: () => _onPressedButton(cubit),
      mainButtonIcon: _getMainButtonIcon(cubit),
      mainButtonLabel: _getMainButtonLabel(context, cubit),
      menuOptions: _getMenuOptions(context),
    );
  }

  void _listener(BuildContext context, StopState state) {
    if (state is StopDepartSuccess) {
      Navigator.of(context).pop();
    }
    if (state is StopArriveFailure) {
      showErrorNotification(context, state.errorMessage);
    }
    if (state is StopDepartFailure) {
      showErrorNotification(context, state.errorMessage);
    }
    if (state is StopCloneFailure) {
      showErrorNotification(context, state.errorMessage);
    }
    if (state is StopCloneSuccess) {
      Navigator.of(context).pushReplacementNamed(
        STOP_PAGE,
        arguments: StopPageArguments(
          stop: state.stop,
          routeCubit: context.read<RouteCubit>(),
        ),
      );
    }
    if (state is StopCancelSuccess ||
        state is StopUndeliverSuccess ||
        state is StopRedeliverSuccess) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  Widget _builder(BuildContext context, StopState state) {
    final cubit = context.watch<StopCubit>();
    return SingleChildScrollView(
      child: Column(
        children: [
          BasicStopInfo(stop: cubit.stop),
          Padding(
            padding: const EdgeInsets.all(14),
            child: TimesCard(stop: cubit.stop),
          ),
        ],
      ),
    );
  }

  Future<void> _onPressedButton(StopCubit cubit) async {
    final stop = cubit.stop;
    final date = DateTime.now().toUtcAsString;
    if (stop.canClone) {
      await cubit.cloneStop(date);
    } else if (stop.hasBeenArrived) {
      await cubit.departStop(date);
    } else {
      await cubit.arriveStop(date);
    }
  }

  Widget _getMainButtonIcon(StopCubit cubit) {
    final stop = cubit.stop;
    final state = cubit.state;
    if (state is StopArriveLoad ||
        state is StopDepartLoad ||
        state is StopCloneLoad) {
      return const GMButtonLoading();
    } else if (stop.canClone) {
      return SvgPicture.asset('assets/icons/clone-stop.svg');
    } else {
      return SvgPicture.asset('assets/icons/driving.svg');
    }
  }

  String _getMainButtonLabel(BuildContext context, StopCubit cubit) {
    final stop = cubit.stop;
    if (stop.canClone) {
      return context.getTextUppercase('stop.clone');
    } else if (stop.hasBeenArrived) {
      return context.getTextUppercase('driver.leave');
    } else {
      return context.getTextUppercase('stop.detail.arrive');
    }
  }

  List<Widget> _getMenuOptions(BuildContext context) {
    final cubit = context.watch<StopCubit>();
    final stop = cubit.stop;
    if (stop.isDone) {
      return [];
    }
    return [
      if (!stop.isCanceled && !stop.hasBeenArrived)
        CancelStopMenuItem(
          onTap: () => Navigator.of(context).pushNamed(
            CHOOSE_CANCEL_CODE_PAGE,
            arguments: cubit,
          ),
        ),
      if (!stop.isUndeliverable && stop.hasBeenArrived) ...[
        UndeliverStopMenuItem(
          onTap: () => Navigator.of(context).pushNamed(
            CHOOSE_UNDELIVERABLE_CODE_PAGE,
            arguments: cubit,
          ),
        ),
        RedeliverStopMenuItem(
          onTap: () => Navigator.of(context).pushNamed(
            CHOOSE_REDELIVER_CODE_PAGE,
            arguments: cubit,
          ),
        ),
      ],
      const HosMenuItem(),
    ];
  }
}
