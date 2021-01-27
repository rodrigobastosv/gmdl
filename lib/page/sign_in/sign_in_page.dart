import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../core/cubit/sign_in/sign_in_cubit.dart';
import '../../core/global/hive.dart';
import '../../core/repository/sign_in_repository.dart';
import 'sign_in_view.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(
        repository: context.read<SignInRepository>(),
        store: Hive.box(CONFIG_BOX),
      ),
      child: SignInView(),
    );
  }
}
