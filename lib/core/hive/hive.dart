import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'boxes.dart';

Future<void> initHiveBoxes() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox(SECURITY_BOX);
  await Hive.openBox(DRIVER_BOX);
  await Hive.openBox(GLOBAL_CONFIGURATIONS_BOX);
  await Hive.openBox(USER_CONFIGURATIONS_BOX);
}
