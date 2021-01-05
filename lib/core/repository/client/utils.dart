import 'package:dio/dio.dart';
import '../../hive/boxes.dart';
import 'package:hive/hive.dart';

Dio getBasicClient() {
  return Dio(
    BaseOptions(
      headers: {
        'Accept': 'application/json',
      },
      queryParameters: {
        'consumer': 'DRIVER',
      },
    ),
  );
}

Dio getDefaultClient() {
  var securityBox = Hive.box(SECURITY_BOX);
  final serverName = securityBox.get(SERVER_NAME);
  final sessionId = securityBox.get(SESSION_ID);
  return Dio(
    BaseOptions(
      headers: {'Accept': 'application/json', 'Cookie': 'SESSION=$sessionId'},
      baseUrl: 'https://$serverName.greenmile.com',
      queryParameters: {
        'consumer': 'DRIVER',
      },
    ),
  );
}
