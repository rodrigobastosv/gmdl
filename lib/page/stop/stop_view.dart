import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/cubit/stop/stop_cubit.dart';
import '../../widget/general/gm_scaffold.dart';
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
    );
  }

  void _listener(BuildContext context, StopState state) {
    if (state is DepartedStopSuccess) {
      Navigator.of(context).pop();
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
    if (stop.isFinished) {
      await cubit.cloneStop();
    } else if (stop.hasBeenArrived) {
      await cubit.departStop();
    } else {
      await cubit.arriveStop();
    }
  }

  Widget _getMainButtonIcon(StopCubit cubit) {
    final stop = cubit.stop;
    if (stop.isFinished) {
      return SvgPicture.asset('assets/icons/clone-stop.svg');
    } else {
      return SvgPicture.asset('assets/icons/driving.svg');
    }
  }

  String _getMainButtonLabel(StopCubit cubit) {
    final stop = cubit.stop;
    if (stop.isFinished) {
      return 'CLONE';
    } else if (stop.hasBeenArrived) {
      return 'LEAVE';
    } else {
      return 'ARRIVE';
    }
  }
}
