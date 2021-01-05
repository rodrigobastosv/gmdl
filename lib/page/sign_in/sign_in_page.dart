import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gm_driver_lite/core/cubit/sign_in/sign_in_cubit.dart';
import 'package:gm_driver_lite/core/repository/sign_in_repository.dart';

import 'sign_in_view.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(
        context.read<SignInRepository>()
      ),
      child: SignInView(),
    );
  }
}
