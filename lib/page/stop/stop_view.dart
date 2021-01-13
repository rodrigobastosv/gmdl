import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
        child: const Icon(
          MdiIcons.truckFastOutline,
          size: 32,
        ),
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
    if (stop.hasBeenArrived) {
      await cubit.departStop();
    } else {
      await cubit.arriveStop();
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
