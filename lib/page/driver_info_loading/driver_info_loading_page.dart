import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gm_driver_lite/core/cubit/driver_info/driver_info_cubit.dart';
import 'package:gm_driver_lite/core/locator.dart';
import 'package:gm_driver_lite/core/repository/driver_info_repository.dart';
import 'package:gm_driver_lite/page/driver_info_loading/driver_info_loading_view.dart';

class DriverInfoLoadingPage extends StatelessWidget {
  const DriverInfoLoadingPage({
    Key key,
    this.username,
  }) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DriverInfoCubit(
        username: username,
        repository: G<DriverInfoRepository>(),
      ),
      child: DriverInfoLoadingView(),
    );
  }
}
