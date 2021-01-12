import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:alice/alice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'core/cubit/cubit_observer.dart';
import 'core/hive/hive.dart';

final alice = Alice(
  showInspectorOnShake: kDebugMode,
);

void main() async {
  initializeDateFormatting('pt_BR', null);
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CubitObserver();
  await initHiveBoxes();
  runApp(
    const App(),
  );
}
