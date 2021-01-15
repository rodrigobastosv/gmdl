import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/cubits.dart';
import 'choose_cancel_code_view.dart';

class ChooseCancelCodePage extends StatelessWidget {
  const ChooseCancelCodePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChooseCancelCodeCubit(),
      child: const ChooseCancelCodeView(),
    );
  }
}
