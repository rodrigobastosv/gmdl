import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../core/cubit/cubits.dart';
import '../../core/global/hive.dart';
import '../../core/repository/client/utils.dart';
import '../../core/repository/initial_settings_repository.dart';
import 'initial_settings_view.dart';

class InitialSettingsPage extends StatelessWidget {
  const InitialSettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InitialSettingsCubit>(
      create: (_) => InitialSettingsCubit(
        repository: InitialSettingsRepository(
          getBasicClient(),
        ),
        globalBox: Hive.box(GLOBAL_BOX),
      ),
      child: InitialSettingsView(),
    );
  }
}
