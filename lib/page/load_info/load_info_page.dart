import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../core/global/global_info.dart';
import '../../core/repository/repositories.dart';
import '../../core/service/device_info_service.dart';
import '../../core/service/package_info_service.dart';
import '../../core/service/services_locator.dart';
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
        i18nCubit: context.read<I18nCubit>(),
        deviceInfoService: G<DeviceInfoService>(),
        packageInfoService: G<PackageInfoService>(),
      )..getDriverInfo(username),
      child: const LoadInfoView(),
    );
  }
}
