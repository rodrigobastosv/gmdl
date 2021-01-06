import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/cubit/cubit_observer.dart';
import 'core/hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CubitObserver();
  await initHiveBoxes();
  runApp(
    const App(),
  );
}
