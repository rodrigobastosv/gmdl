import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'core/provider/global_info_provider.dart';

class GlobalApp extends StatelessWidget {
  const GlobalApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GlobalInfoProvider>(
      create: (_) => GlobalInfoProvider(),
      child: App(),
    );
  }
}