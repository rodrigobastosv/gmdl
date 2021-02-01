import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../global/hive.dart';
import 'client/gm_client.dart';
import 'client/utils.dart';
import 'loading_info_repository.dart';
import 'repositories.dart';
import 'sign_in_repository.dart';

List<RepositoryProvider> getRepositoryProviders(Box globalBox) {
  final serverName = globalBox.get(SERVER);
  final sessionId = globalBox.get(TOKEN);
  final client = GMClient(getDefaultClient(serverName, sessionId));
  return [
    RepositoryProvider<SignInRepository>(
      create: (_) => SignInRepository(client),
    ),
    RepositoryProvider<LoadingInfoRepository>(
      create: (_) => LoadingInfoRepository(client),
    ),
    RepositoryProvider<EquipmentRepository>(
      create: (_) => EquipmentRepository(client),
    ),
    RepositoryProvider<RouteRepository>(
      create: (_) => RouteRepository(client),
    ),
    RepositoryProvider<StopRepository>(
      create: (_) => StopRepository(client),
    ),
    RepositoryProvider<EntityRepository>(
      create: (_) => EntityRepository(client),
    ),
    RepositoryProvider<NotificationRepository>(
      create: (_) => NotificationRepository(client),
    ),
    RepositoryProvider<I18nRepository>(
      create: (_) => I18nRepository(client),
    ),
  ];
}
