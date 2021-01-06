import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/choose_equipment/choose_equipment_cubit.dart';
import 'choose_equipment_view.dart';

class ChooseEquipmentPage extends StatelessWidget {
  const ChooseEquipmentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChooseEquipmentCubit>(
      create: (_) => ChooseEquipmentCubit(),
      child: ChooseEquipmentView(),
    );
  }
}
