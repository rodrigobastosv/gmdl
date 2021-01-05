// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'app.dart';
import 'core/hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveBoxes();
  runApp(
    const App(),
  );
}
