import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../widget/alert/notification.dart';
import '../../widget/general/gm_scaffold.dart';
import '../pages.dart';
import 'widget/initial_settings_form.dart';

class InitialSettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GMScaffold(
      backgroundColor: const Color(0xFF24242A),
      title: 'SETTINGS',
      withDrawer: false,
      withBackButton: false,
      withNavigationBar: false,
      body: BlocConsumer<InitialSettingsCubit, InitialSettingsState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }

  void _listener(BuildContext context, InitialSettingsState state) {
    if (state is ServerValidationSuccess) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SignInPage(),
        ),
      );
    } else if (state is ServerValidationFailed) {
      showErrorNotification(state.errorMessage);
    }
  }

  Widget _builder(BuildContext context, InitialSettingsState state) =>
      InitialSettingsForm();
}
