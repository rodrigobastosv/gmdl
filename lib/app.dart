import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/repository/repositories_provider.dart';
import 'page/pages.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: getProviders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: const Color(0xFFB0D25A),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const InitialSettingsPage(),
      ),
    );
  }
}
