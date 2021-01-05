import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../core/cubit/initial_setup/initial_setup_cubit.dart';
import '../../core/hive/boxes.dart';
import '../../core/repository/client/utils.dart';
import '../../core/repository/initial_setup_repository.dart';
import 'initial_setup_view.dart';

class InitialSetupPage extends StatelessWidget {
  const InitialSetupPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InitialSetupCubit>(
      create: (_) => InitialSetupCubit(
        repository: InitialSetupRepository(
          getBasicClient(),
        ),
        securityBox: Hive.box(SECURITY_BOX),
      ),
      child: InitialSetupView(),
    );
  }
}
