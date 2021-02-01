import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../core/cubit/cubits.dart';
import '../../../core/cubit/stop/stop_cubit.dart';
import '../../../core/selector/global_info_selectors.dart';
import '../../../widget/general/gm_scaffold.dart';

class ChooseRedeliverCodePage extends StatelessWidget {
  static const routeName = 'ChooseRedeliverCodePage';

  const ChooseRedeliverCodePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stopCubit = context.watch<StopCubit>();
    final cubit = context.watch<ChooseRedeliverCodeCubit>();
    final allRedeliverCodes =
        getRedeliveryReasons(stopCubit.allUndeliveableCodes);
    return GMScaffold(
      title: 'REDELIVERY CODES',
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
          ? () {
              final pickedRedeliverableCode = cubit.pickedRedeliverableCode;
              stopCubit.redeliverStop(pickedRedeliverableCode);
            }
          : null,
      mainButtonIcon: SvgPicture.asset(
        'assets/icons/checkmark.svg',
        height: 22,
        width: 22,
      ),
      mainButtonLabel: 'SELECT',
    );
  }
}
