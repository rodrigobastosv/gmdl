import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gm_driver_lite/core/cubit/initial_setup/initial_setup_cubit.dart';
import 'package:gm_driver_lite/core/repository/initial_setup_repository.dart';
import 'package:gm_driver_lite/page/initial_setup/initial_setup_view.dart';

class InitialSetupPage extends StatelessWidget {
  const InitialSetupPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InitialSetupCubit>(
      create: (_) => InitialSetupCubit(
        InitialSetupRepository(
          Dio(),
        ),
      ),
      child: InitialSetupView(),
    );
  }
}
