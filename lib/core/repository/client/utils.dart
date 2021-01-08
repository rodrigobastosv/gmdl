import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../exception/exceptions.dart';
import '../../hive/boxes.dart';
import 'client.dart';

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

dynamic handleResponse(Response response) {
  if (response.isNotOk) {
    throw GMServerException(response.statusCode, response.statusMessage);
  }
  return response.data;
}
