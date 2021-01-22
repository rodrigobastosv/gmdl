import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../core/extension/i18n_cubit_extension.dart';
import '../../widget/alert/notification.dart';
import '../../widget/general/gm_scaffold.dart';
import '../pages.dart';
import 'widget/initial_settings_form.dart';

class InitialSettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18nCubit, I18nState>(
      builder: (_, state) => GMScaffold(
        backgroundColor: const Color(0xFF24242A),
        title: context.getTextUppercase('loader.settings'),
        withDrawer: false,
        withBackButton: false,
        withNavigationBar: false,
        body: BlocConsumer<InitialSettingsCubit, InitialSettingsState>(
          listener: _listener,
          builder: _builder,
        ),
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
