import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../core/cubit/cubits.dart';
import '../../../core/cubit/stop/stop_cubit.dart';
import '../../../core/selector/store_selectors.dart';
import '../../../widget/general/gm_scaffold.dart';

class ChooseRedeliverCodeView extends StatelessWidget {
  const ChooseRedeliverCodeView({Key key}) : super(key: key);

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
      mainActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: cubit.hasRedeliverableCodePicked
            ? () {
                final pickedRedeliverableCode = cubit.pickedRedeliverableCode;
                stopCubit.redeliverStop(pickedRedeliverableCode);
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