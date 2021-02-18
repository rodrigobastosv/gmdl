import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../alert/gm_confirmation_dialog_with_timer.dart';

import '../../core/cubit/cubits.dart';
import '../../core/extension/extensions.dart';
import '../general/gm_menu_option.dart';

class HosLunchMenuItem extends StatelessWidget {
  const HosLunchMenuItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GMMenuOption(
      text: context.getText('hos.lunch.title'),
      icon: 'lunch',
      onTap: () => showDialog(
        context: context,
        builder: (_) => GMConfirmationDialogWithTimer(
          onConfirm: () => context.read<HosCubit>().startLunch(
                DateTime.now().toUtcAsString,
              ),
          title: context.getText('driver.hoscountdown.title'),
          description:
              context.getText('driver.hoscountdown.driver.description'),
          seconds: 5,
        ),
      ),
    );
  }
}
