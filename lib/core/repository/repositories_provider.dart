import 'package:flutter_bloc/flutter_bloc.dart';

import 'client/utils.dart';
import 'loading_info_repository.dart';
import 'repositories.dart';
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
    RepositoryProvider<EquipmentRepository>(
      create: (_) => EquipmentRepository(
        getDefaultClient(),
      ),
    ),
    RepositoryProvider<RouteRepository>(
      create: (_) => RouteRepository(
        getDefaultClient(),
      ),
    ),
    RepositoryProvider<StopRepository>(
      create: (_) => StopRepository(
        getDefaultClient(),
      ),
    ),
  ];
}
