import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:alice/alice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/cubit/cubit_observer.dart';
import 'core/global/hive.dart';
import 'widget/core/gm_app.dart';

Alice alice = Alice(
  showInspectorOnShake: kDebugMode,
);

const sentryDSN =
    'https://824d89780eb8463b821ce4f6febb8f34@o401245.ingest.sentry.io/5610722';

void main() async {
  initializeDateFormatting('pt_BR', null);
  WidgetsFlutterBinding.ensureInitialized();
  final _packageInfo = await PackageInfo.fromPlatform();
  final _directory = await getApplicationDocumentsDirectory();
  await Hive.init(_directory.path);
  await Hive.openBox(GLOBAL_BOX);
  Firebase.initializeApp();
  Bloc.observer = CubitObserver();
  await SentryFlutter.init(
    (options) => options.dsn = sentryDSN,
    appRunner: () => runApp(
      GMApp(packageInfo: _packageInfo),
    ),
  );
}
