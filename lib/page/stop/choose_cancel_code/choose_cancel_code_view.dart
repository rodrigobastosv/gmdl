import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../core/cubit/cubits.dart';
import '../../../core/cubit/stop/stop_cubit.dart';
import '../../../widget/general/gm_scaffold.dart';

class ChooseCancelCodeView extends StatelessWidget {
  const ChooseCancelCodeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stopCubit = context.watch<StopCubit>();
    final cubit = context.watch<ChooseCancelCodeCubit>();
    final allCancelCodes = stopCubit.allCancelCodes;
    return GMScaffold(
      title: 'REASON CODES',
      body: BlocBuilder<StopCubit, StopState>(
        builder: (_, state) => ListView.builder(
          itemBuilder: (_, i) => ListTile(
            key: UniqueKey(),
            title: Text(allCancelCodes[i].description),
            trailing: RoundCheckBox(
              isChecked: cubit.pickedCancelCode == allCancelCodes[i],
              onTap: (selected) {
                if (selected) {
                  cubit.pickCancelCode(allCancelCodes[i]);
                } else {
                  cubit.unpickCancelCode(allCancelCodes[i]);
                }
              },
            ),
          ),
          itemCount: allCancelCodes.length,
        ),
      ),
      mainActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: cubit.hasCancelCodePicked
            ? () {
                final pickedCancelCode = cubit.pickedCancelCode;
                stopCubit.cancelStop(pickedCancelCode.id);
              }
            : null,
        child: SvgPicture.asset(
          'assets/icons/checkmark.svg',
          height: 22,
          width: 22,
        ),
      ),
      mainActionButtonLabel: 'SELECT',
    );
  }
}
