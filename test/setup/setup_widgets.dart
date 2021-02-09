import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';

import 'package:gm_driver_lite/core/global/hive.dart';

void setupWidgetsForTesting() async {
  initializeDateFormatting('pt_BR', null);
  final directory = await getApplicationDocumentsDirectory();
  await Hive.init(directory.path);
  await Hive.openBox(GLOBAL_BOX);
}
