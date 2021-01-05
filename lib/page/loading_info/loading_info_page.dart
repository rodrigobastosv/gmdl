import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../core/cubit/loading_info/loading_info_cubit.dart';
import '../../core/hive/boxes.dart';
import '../../core/repository/repositories.dart';
import 'loading_info_view.dart';

class LoadingInfoPage extends StatelessWidget {
  const LoadingInfoPage({
    Key key,
    this.username,
  }) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoadingInfoCubit(
        repository: context.read<LoadingInfoRepository>(),
        driverBox: Hive.box(DRIVER_BOX),
        configurationsBox: Hive.box(CONFIGURATIONS_BOX),
      )..getDriverInfo(username),
      child: const LoadingInfoView(),
    );
  }
}
