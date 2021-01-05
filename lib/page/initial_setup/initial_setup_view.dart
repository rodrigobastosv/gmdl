// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../core/cubit/initial_setup/initial_setup_cubit.dart';
import '../sign_in/sign_in_page.dart';
import 'widget/initial_setup_form.dart';

class InitialSetupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
