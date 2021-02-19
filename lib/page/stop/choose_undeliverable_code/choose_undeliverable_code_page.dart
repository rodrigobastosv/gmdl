import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../core/cubit/cubits.dart';
import '../../../core/extension/extensions.dart';
import '../../../widget/general/gm_scaffold.dart';

class ChooseUndeliverableCodePage extends StatelessWidget {
  const ChooseUndeliverableCodePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stopCubit = context.watch<StopCubit>();
    final cubit = context.watch<ChooseUndeliverableCodeCubit>();
    final allUndeliverableCodes = stopCubit.allUndeliveableCodes;
    return GMScaffold(
      title: context.getTextUppercase('general.reasonCode'),
      body: BlocBuilder<StopCubit, StopState>(
        builder: (_, state) => ListView.builder(
          itemBuilder: (_, i) => ListTile(
            key: UniqueKey(),
            title: Text(allUndeliverableCodes[i].description),
            trailing: RoundCheckBox(
              isChecked:
                  cubit.pickedUndeliverableCode == allUndeliverableCodes[i],
              onTap: (selected) {
                if (selected) {
                  cubit.pickUndeliverableCode(allUndeliverableCodes[i]);
                } else {
                  cubit.unpickUndeliverableCode(allUndeliverableCodes[i]);
                }
              },
            ),
          ),
          itemCount: allUndeliverableCodes.length,
        ),
      ),
      mainButtonAction: cubit.hasUndeliverableCodePicked
          ? () {
              final pickedUndeliverableCode = cubit.pickedUndeliverableCode;
              stopCubit.undeliverStop(
                undeliverableCode: pickedUndeliverableCode,
                actualDeparture: DateTime.now().toUtcAsString,
              );
            }
          : null,
      mainButtonIcon: SvgPicture.asset(
        'assets/icons/checkmark.svg',
        height: 22,
        width: 22,
      ),
      mainButtonLabel: context.getTextUppercase('loader.select'),
    );
  }
}
