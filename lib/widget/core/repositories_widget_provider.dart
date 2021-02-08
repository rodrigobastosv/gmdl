import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../core/global/hive.dart';
import '../../core/repository/client/gm_client.dart';
import '../../core/repository/repositories.dart';

class RepositoriesWidgetProvider extends StatefulWidget {
  const RepositoriesWidgetProvider({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  _RepositoriesWidgetProviderState createState() =>
      _RepositoriesWidgetProviderState();
}

class _RepositoriesWidgetProviderState
    extends State<RepositoriesWidgetProvider> {
  StreamSubscription serverNameSubscription;
  StreamSubscription tokenSubscription;
  StreamSubscription usernameSubscription;
  StreamSubscription passwordSubscription;

  @override
  void didChangeDependencies() {
    serverNameSubscription =
        Hive.box(GLOBAL_BOX).watch(key: SERVER).listen((e) {
      final gmClient = context.read<GMClient>();
      gmClient.serverName = e.value;
    });

    tokenSubscription = Hive.box(GLOBAL_BOX).watch(key: TOKEN).listen((e) {
      final gmClient = context.read<GMClient>();
      gmClient.sessionId = e.value;
    });

    usernameSubscription =
        Hive.box(GLOBAL_BOX).watch(key: USERNAME).listen((e) {
      final gmClient = context.read<GMClient>();
      gmClient.username = e.value;
    });

    passwordSubscription =
        Hive.box(GLOBAL_BOX).watch(key: PASSWORD).listen((e) {
      final gmClient = context.read<GMClient>();
      gmClient.password = e.value;
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    serverNameSubscription.cancel();
    tokenSubscription.cancel();
    usernameSubscription.cancel();
    passwordSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SignInRepository>(
          create: (_) => SignInRepository(context.read<GMClient>()),
        ),
        RepositoryProvider<LoadingInfoRepository>(
          create: (_) => LoadingInfoRepository(context.read<GMClient>()),
        ),
        RepositoryProvider<EquipmentRepository>(
          create: (_) => EquipmentRepository(context.read<GMClient>()),
        ),
        RepositoryProvider<RouteRepository>(
          create: (_) => RouteRepository(context.read<GMClient>()),
        ),
        RepositoryProvider<StopRepository>(
          create: (_) => StopRepository(context.read<GMClient>()),
        ),
        RepositoryProvider<EntityRepository>(
          create: (_) => EntityRepository(context.read<GMClient>()),
        ),
        RepositoryProvider<NotificationRepository>(
          create: (_) => NotificationRepository(context.read<GMClient>()),
        ),
        RepositoryProvider<I18nRepository>(
          create: (_) => I18nRepository(context.read<GMClient>()),
        ),
      ],
      child: widget.child,
    );
  }
}
