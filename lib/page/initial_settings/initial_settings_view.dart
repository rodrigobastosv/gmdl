import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/cubit/cubits.dart';

import '../sign_in/sign_in_page.dart';
import 'widget/initial_settings_form.dart';

class InitialSettingsView extends StatelessWidget {
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
      body: BlocConsumer<InitialSettingsCubit, InitialSettingsState>(
        listener: (_, state) {
          if (state is ServerValidationSuccess) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => SignInPage(),
              ),
            );
          }
        },
        builder: (_, state) => InitialSettingsForm(),
      ),
    );
  }
}
