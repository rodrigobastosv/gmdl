import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:alice/alice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'connected_app.dart';
import 'core/cubit/cubit_observer.dart';

final alice = Alice(
  showInspectorOnShake: kDebugMode,
);

void main() async {
  initializeDateFormatting('pt_BR', null);
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  Bloc.observer = CubitObserver();
  runApp(
    const ConnectedApp(),
  );
}
