import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gm_driver_lite/page/driver_info_loading/driver_info_loading_page.dart';
import 'package:provider/provider.dart';

import 'core/provider/global_info_provider.dart';
import 'core/repository/repositories_provider.dart';
import 'main.dart';
import 'page/initial_setup/initial_setup_page.dart';
import 'page/sign_in/sign_in_page.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalInfoProvider>(
      builder: (_, globalInfo, __) => _getTarget(globalInfo),
    );
  }

  Widget _getTarget(GlobalInfoProvider globalInfo) {
    if (globalInfo.isUserSignedIn) {
      return _getSignInSuccess(globalInfo);
    } else if (globalInfo.isServerValidated) {
      return _getServerValidated();
    }
    return _getInitialSetup();
  }

  Widget _getServerValidated() {
    return MultiRepositoryProvider(
      providers: getProviders(null),
      child: MaterialApp(
        navigatorKey: alice.getNavigatorKey(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SignInPage(),
      ),
    );
  }

  Widget _getSignInSuccess(GlobalInfoProvider globalInfo) {
    return MultiRepositoryProvider(
      providers: getProviders(globalInfo.sessionId),
      child: MaterialApp(
        navigatorKey: alice.getNavigatorKey(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DriverInfoLoadingPage(username: globalInfo.username),
      ),
    );
  }

  Widget _getInitialSetup() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InitialSetupPage(),
    );
  }
}
