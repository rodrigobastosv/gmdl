import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/cubits.dart';
import 'choose_redeliver_code_view.dart';

class ChooseRedeliverCodePage extends StatelessWidget {
  const ChooseRedeliverCodePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChooseRedeliverCodeCubit(),
      child: const ChooseRedeliverCodeView(),
    );
  }
}
