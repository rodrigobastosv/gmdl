import 'package:flutter/material.dart';

import 'package:device_info/device_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../core/global/global_info.dart';
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
        globalInfo: context.read<GlobalInfo>(),
        deviceInfo: DeviceInfoPlugin(),
        i18nCubit: context.read<I18nCubit>(),
      )..getDriverInfo(username),
      child: const LoadInfoView(),
    );
  }
}
