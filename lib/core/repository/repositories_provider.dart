import 'package:flutter_bloc/flutter_bloc.dart';

import '../store/store.dart';
import 'client/utils.dart';
import 'loading_info_repository.dart';
import 'repositories.dart';
import 'sign_in_repository.dart';

List<RepositoryProvider> getRepositoryProviders(Store store) {
  final serverName = store.serverName;
  final sessionId = store.sessionId;
  return [
    RepositoryProvider<SignInRepository>(
      create: (_) => SignInRepository(
        getDefaultClient(serverName, sessionId),
      ),
    ),
    RepositoryProvider<LoadingInfoRepository>(
      create: (_) => LoadingInfoRepository(
        getDefaultClient(serverName, sessionId),
      ),
    ),
    RepositoryProvider<EquipmentRepository>(
      create: (_) => EquipmentRepository(
        getDefaultClient(serverName, sessionId),
      ),
    ),
    RepositoryProvider<RouteRepository>(
      create: (_) => RouteRepository(
        getDefaultClient(serverName, sessionId),
      ),
    ),
    RepositoryProvider<StopRepository>(
      create: (_) => StopRepository(
        getDefaultClient(serverName, sessionId),
      ),
    ),
    RepositoryProvider<EntityRepository>(
      create: (_) => EntityRepository(
        getDefaultClient(serverName, sessionId),
      ),
    ),
    RepositoryProvider<NotificationRepository>(
      create: (_) => NotificationRepository(
        getDefaultClient(serverName, sessionId),
      ),
    ),
  ];
}
