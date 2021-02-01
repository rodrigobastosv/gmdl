import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/cubit/cubits.dart';
import '../../core/cubit/stop/stop_cubit.dart';
import '../../core/extension/i18n_cubit_extension.dart';
import '../../widget/general/gm_menu_option.dart';
import '../../widget/general/gm_scaffold.dart';
import '../pages.dart';
import '../pages_names.dart';
import 'widget/instructions_card.dart';

class StopView extends StatelessWidget {
  const StopView({Key key}) : super(key: key);

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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: context.read<RouteCubit>(),
            child: StopPage(stop: state.stop),
          ),
          settings: const RouteSettings(name: STOP_PAGE),
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
    if (stop.canClone) {
      await cubit.cloneStop();
    } else if (stop.hasBeenArrived) {
      await cubit.departStop();
    } else {
      await cubit.arriveStop();
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
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: cubit,
                  child: const ChooseCancelCodePage(),
                ),
                settings: const RouteSettings(name: CHOOSE_CANCEL_CODE_PAGE),
              ),
            );
          },
        ),
      if (!stop.isUndeliverable && stop.hasBeenArrived) ...[
        GMMenuOption(
          text: context.getText('status.undeliverable'),
          icon: 'undeliver',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: cubit,
                  child: const ChooseUndeliverableCodePage(),
                ),
                settings:
                    const RouteSettings(name: CHOOSE_UNDELIVERABLE_CODE_PAGE),
              ),
            );
          },
        ),
        GMMenuOption(
          text: context.getText('stop.redelivery'),
          icon: 'redeliver',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: cubit,
                  child: const ChooseRedeliverCodePage(),
                ),
                settings: const RouteSettings(name: CHOOSE_REDELIVER_CODE_PAGE),
              ),
            );
          },
        ),
      ]
    ];
  }
}
