import 'package:gm_driver_lite/core/global/hive.dart';
import 'package:gm_driver_lite/core/service/services_locator.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void setupWidgetsForTesting() async {
  initializeDateFormatting('pt_BR', null);
  await initServices();
  final directory = await getApplicationDocumentsDirectory();
  await Hive.init(directory.path);
  await Hive.openBox(GLOBAL_BOX);
}
