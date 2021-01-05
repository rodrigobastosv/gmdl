import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'core/provider/global_info_provider.dart';
import 'core/repository/repositories_provider.dart';
import 'page/initial_setup/initial_setup_page.dart';
import 'page/sign_in/sign_in_page.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalInfoProvider>(
      builder: (_, controller, __) =>
          controller.isServerValidated ? _getServerValidated() : _getInitial(),
    );
  }

  Widget _getServerValidated() {
    return MultiRepositoryProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SignInPage(),
      ),
    );
  }

  Widget _getInitial() {
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
