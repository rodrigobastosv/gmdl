import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../core/repository/client/utils.dart';
import '../../core/repository/initial_setup_repository.dart';
import '../../core/store/store_provider.dart';
import 'initial_settings_view.dart';

class InitialSettingsPage extends StatelessWidget {
  const InitialSettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InitialSettingsCubit>(
      create: (_) => InitialSettingsCubit(
        repository: InitialSetupRepository(
          getBasicClient(),
        ),
        storeProvider: context.read<StoreProvider>(),
      ),
      child: InitialSettingsView(),
    );
  }
}
