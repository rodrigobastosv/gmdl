import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/initial_setup/initial_setup_cubit.dart';
import '../sign_in/sign_in_page.dart';
import 'widget/initial_setup_form.dart';

class InitialSetupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24242A),
      appBar: AppBar(
        title: const Text(
          'SETTINGS',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<InitialSetupCubit, InitialSetupState>(
        listener: (_, state) {
          if (state is ServerValidationSuccess) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => SignInPage(),
              ),
            );
          }
        },
        builder: (_, state) => InitialSetupForm(),
      ),
    );
  }
}
