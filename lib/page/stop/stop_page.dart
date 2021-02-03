import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/cubit/cubits.dart';
import '../../core/cubit/stop/stop_cubit.dart';
import '../../core/extension/i18n_cubit_extension.dart';
import '../../core/route/route.dart';
import '../../widget/general/gm_menu_option.dart';
import '../../widget/general/gm_scaffold.dart';
import 'stop_page_arguments.dart';
import 'widget/instructions_card.dart';

import '../../core/extension/extensions.dart';

class StopPage extends StatelessWidget {
  const StopPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<StopCubit>();
    return GMScaffold(
      backgroundColor: Colors.grey[200],
      title: context.getTextUppercase('details.label.departure'),
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
    if (state is DepartedStopSuccess) {
      Navigator.of(context).pop();
    }
    if (state is ClonedStopSuccess) {
      Navigator.of(context).pushReplacementNamed(
        STOP_PAGE,
        arguments: StopPageArguments(
          stop: state.stop,
          routeCubit: context.read<RouteCubit>(),
        ),
      );
    }
    if (state is CanceledStopSuccess ||
        state is UndeliveredStopSuccess ||
        state is RedeliveredStopSuccess) {
      Navigator.of(context)
          .popUntil((route) => route.settings.name == STOP_LIST_PAGE);
    }
  }

  Widget _builder(BuildContext context, StopState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const InstructionsCard(),
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
    if (stop.canClone) {
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

  List<GMMenuOption> _getMenuOptions(BuildContext context) {
    final cubit = context.watch<StopCubit>();
    final stop = cubit.stop;
    if (stop.isDone) {
      return [];
    }
    return [
      if (!stop.isCanceled && !stop.hasBeenArrived)
        GMMenuOption(
          text: context.getText('stop.cancel'),
          icon: 'cancel-stop',
          onTap: () => Navigator.of(context).pushNamed(
            CHOOSE_CANCEL_CODE_PAGE,
            arguments: cubit,
          ),
        ),
      if (!stop.isUndeliverable && stop.hasBeenArrived) ...[
        GMMenuOption(
          text: context.getText('status.undeliverable'),
          icon: 'undeliver',
          onTap: () => Navigator.of(context).pushNamed(
            CHOOSE_UNDELIVERABLE_CODE_PAGE,
            arguments: cubit,
          ),
        ),
        GMMenuOption(
          text: context.getText('stop.redelivery'),
          icon: 'redeliver',
          onTap: () => Navigator.of(context).pushNamed(
            CHOOSE_REDELIVER_CODE_PAGE,
            arguments: cubit,
          ),
        ),
      ]
    ];
  }
}
