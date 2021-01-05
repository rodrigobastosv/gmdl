import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gm_driver_lite/core/repository/loading_info_repository.dart';
import 'package:gm_driver_lite/core/repository/client/utils.dart';

import 'sign_in_repository.dart';

List<RepositoryProvider> getProviders() {
  return [
    RepositoryProvider<SignInRepository>(
      create: (_) => SignInRepository(
        getDefaultClient(),
      ),
    ),
    RepositoryProvider<LoadingInfoRepository>(
      create: (_) => LoadingInfoRepository(
        getDefaultClient(),
      ),
    ),
  ];
}
