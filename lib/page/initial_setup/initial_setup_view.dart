import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gm_driver_lite/core/cubit/initial_setup/initial_setup_cubit.dart';
import 'package:gm_driver_lite/core/provider/global_info_provider.dart';
import 'package:gm_driver_lite/page/initial_setup/widget/initial_setup_form.dart';

class InitialSetupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<InitialSetupCubit, InitialSetupState>(
        listener: (_, state) {
          if (state is ServerValidationSuccess) {
            context
                .read<GlobalInfoProvider>()
                .changeServerName(state.serverName);
          }
        },
        builder: (_, state) => InitialSetupForm(),
      ),
    );
  }
}
