import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'app.dart';
import 'core/store/store.dart';

class ConnectedApp extends StatelessWidget {
  const ConnectedApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Store>(
      create: (_) => Store(),
      child: const App(),
    );
  }
}
