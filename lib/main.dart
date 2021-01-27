import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:alice/alice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/service/services_locator.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'core/cubit/cubit_observer.dart';
import 'core/global/hive.dart';

final alice = Alice(
  showInspectorOnShake: kDebugMode,
);

void main() async {
  initializeDateFormatting('pt_BR', null);
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  final directory = await getApplicationDocumentsDirectory();
  await Hive.init(directory.path);
  await Hive.openBox(CONFIG_BOX);
  Firebase.initializeApp();
  Bloc.observer = CubitObserver();
  runApp(const App());
}
