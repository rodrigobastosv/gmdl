import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
      onTap: () => context.read<HosCubit>().startLunch(
            DateTime.now().toUtcAsString,
          ),
    );
  }
}
