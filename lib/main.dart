import 'package:flutter/material.dart';

import 'app.dart';
import 'core/hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveBoxes();
  runApp(
    const App(),
  );
}
