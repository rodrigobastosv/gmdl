import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/cubit/cubits.dart';
import '../../core/cubit/stop/stop_cubit.dart';
import '../../widget/general/gm_menu_option.dart';
import '../../widget/general/gm_scaffold.dart';
import '../pages.dart';
import '../stop_list/stop_list_page.dart';
import 'widget/instructions_card.dart';

class StopView extends StatelessWidget {
  const StopView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<StopCubit>();
    return GMScaffold(
      backgroundColor: Colors.grey[200],
      title: 'DEPARTURE',
      body: BlocConsumer<StopCubit, StopState>(
        listener: _listener,
        builder: _builder,
      ),
      mainActionButton: FloatingActionButton(
        onPressed: () => _onPressedButton(cubit),
        child: _getMainButtonIcon(cubit),
        backgroundColor: const Color(0xFF3AA348),
      ),
      mainActionButtonLabel: _getMainButtonLabel(cubit),
      menuOptions: _getMenuOptions(context),
    );
  }

  void _listener(BuildContext context, StopState state) {
    if (state is DepartedStopSuccess) {
      Navigator.of(context).pop();
    }
    if (state is CanceledStopSuccess ||
        state is UndeliveredStopSuccess ||
        state is RedeliveredStopSuccess) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: context.read<RouteCubit>(),
            child: const StopListPage(),
          ),
        ),
      );
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

  String _getMainButtonLabel(StopCubit cubit) {
    final stop = cubit.stop;
    if (stop.canClone) {
      return 'CLONE';
    } else if (stop.hasBeenArrived) {
      return 'LEAVE';
    } else {
      return 'ARRIVE';
    }
  }

  List<GMMenuOption> _getMenuOptions(BuildContext context) {
    final cubit = context.watch<StopCubit>();
    final stop = cubit.stop;
    return [
      if (!stop.isCanceled && !stop.hasBeenArrived)
        GMMenuOption(
          text: 'Cancel',
          icon: 'cancel-stop',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: cubit,
                  child: const ChooseCancelCodePage(),
                ),
              ),
            );
          },
        ),
      if (!stop.isUndeliverable && stop.hasBeenArrived) ...[
        GMMenuOption(
          text: 'Uncompleted',
          icon: 'undeliverable',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: cubit,
                  child: const ChooseUndeliverableCodePage(),
                ),
              ),
            );
          },
        ),
        GMMenuOption(
          text: 'Redeliver',
          icon: 'redeliver',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: cubit,
                  child: const ChooseRedeliverCodePage(),
                ),
              ),
            );
          },
        ),
      ]
    ];
  }
}
