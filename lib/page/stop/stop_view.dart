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
    return GMScaffold(
      backgroundColor: Colors.grey[200],
      title: 'DEPARTURE',
      body: BlocConsumer<StopCubit, StopState>(
        listener: _listener,
        builder: _builder,
      ),
      mainActionButton: FloatingActionButton(
        onPressed: () => context.read<StopCubit>().departStop(),
        child: const Icon(
          MdiIcons.truckFastOutline,
          size: 32,
        ),
        backgroundColor: const Color(0xFF3AA348),
      ),
      mainActionButtonLabel: 'LEAVE',
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
}
