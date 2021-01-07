import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/cubit/cubits.dart';
import 'package:hive/hive.dart';

import '../../core/hive/boxes.dart';
import '../../core/repository/repositories.dart';
import 'load_info_view.dart';

class LoadInfoPage extends StatelessWidget {
  const LoadInfoPage({
    Key key,
    this.username,
  }) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoadInfoCubit(
        repository: context.read<LoadingInfoRepository>(),
        driverBox: Hive.box(DRIVER_BOX),
        globalConfigurationsBox: Hive.box(GLOBAL_CONFIGURATIONS_BOX),
        userConfigurationsBox: Hive.box(USER_CONFIGURATIONS_BOX),
      )..getDriverInfo(username),
      child: const LoadInfoView(),
    );
  }
}
