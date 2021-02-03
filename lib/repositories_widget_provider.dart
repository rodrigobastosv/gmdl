import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'core/global/hive.dart';
import 'core/repository/client/gm_client.dart';
import 'core/repository/repositories_provider.dart';
import 'core/service/services_locator.dart';

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
  void initState() {
    serverNameSubscription =
        Hive.box(GLOBAL_BOX).watch(key: SERVER).listen((e) {
      final gmClient = G<GMClient>();
      gmClient.serverName = e.value;
    });

    tokenSubscription = Hive.box(GLOBAL_BOX).watch(key: TOKEN).listen((e) {
      final gmClient = G<GMClient>();
      gmClient.sessionId = e.value;
    });

    usernameSubscription =
        Hive.box(GLOBAL_BOX).watch(key: USERNAME).listen((e) {
      final gmClient = G<GMClient>();
      gmClient.username = e.value;
    });

    passwordSubscription =
        Hive.box(GLOBAL_BOX).watch(key: PASSWORD).listen((e) {
      final gmClient = G<GMClient>();
      gmClient.password = e.value;
    });
    super.initState();
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
      providers: getRepositoryProviders(),
      child: widget.child,
    );
  }
}
