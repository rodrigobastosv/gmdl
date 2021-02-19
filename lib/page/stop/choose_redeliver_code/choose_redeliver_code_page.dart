import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../core/cubit/cubits.dart';
import '../../../core/extension/extensions.dart';
import '../../../core/utils/utils.dart';
import '../../../widget/general/gm_scaffold.dart';

class ChooseRedeliverCodePage extends StatelessWidget {
  const ChooseRedeliverCodePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stopCubit = context.watch<StopCubit>();
    final cubit = context.watch<ChooseRedeliverCodeCubit>();
    final allRedeliverCodes =
        getRedeliveryReasons(stopCubit.allUndeliveableCodes);
    return GMScaffold(
      title: context.getTextUppercase('general.reasonCode'),
      body: BlocBuilder<StopCubit, StopState>(
        builder: (_, state) => ListView.builder(
          itemBuilder: (_, i) => ListTile(
            key: UniqueKey(),
            title: Text(allRedeliverCodes[i].description),
            trailing: RoundCheckBox(
              isChecked: cubit.pickedRedeliverableCode == allRedeliverCodes[i],
              onTap: (selected) {
                if (selected) {
                  cubit.pickRedeliverCode(allRedeliverCodes[i]);
                } else {
                  cubit.unpickRedeliverCode(allRedeliverCodes[i]);
                }
              },
            ),
          ),
          itemCount: allRedeliverCodes.length,
        ),
      ),
      mainButtonAction: cubit.hasRedeliverableCodePicked
          ? () async {
              final pickedRedeliverableCode = cubit.pickedRedeliverableCode;
              final suggestedTimeWindowTime = await showGMTimePicker(
                context,
                helperText: context.getText('driver.reschedule.popup.content'),
                confirmText: context.getText('general.button.confirm'),
                cancelText:
                    context.getText('driver.cancel.suggestedTimeWindowOpen'),
              );
              final suggestedTimeWindow =
                  getHourMinuteFromTimeOfDay(suggestedTimeWindowTime);
              stopCubit.redeliverStop(
                undeliverableCode: pickedRedeliverableCode,
                actualDeparture: DateTime.now().toUtcAsString,
                suggestedTimeWindow: suggestedTimeWindow,
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
