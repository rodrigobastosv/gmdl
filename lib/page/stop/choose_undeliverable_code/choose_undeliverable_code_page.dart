import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/cubits.dart';
import 'choose_undeliverable_code_view.dart';

class ChooseUndeliverableCodePage extends StatelessWidget {
  const ChooseUndeliverableCodePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChooseUndeliverableCodeCubit(),
      child: const ChooseUndeliverableCodeView(),
    );
  }
}
