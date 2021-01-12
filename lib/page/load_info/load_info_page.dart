import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../core/repository/repositories.dart';
import '../../core/store/store_provider.dart';
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
        storeProvider: context.read<StoreProvider>(),
      )..getDriverInfo(username),
      child: const LoadInfoView(),
    );
  }
}
