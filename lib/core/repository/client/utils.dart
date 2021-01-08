import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../../main.dart';
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
  )..interceptors.addAll(_getBasicInterceptors());
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
  )..interceptors.addAll(_getBasicInterceptors());
}

List<Interceptor> _getBasicInterceptors() {
  if (kDebugMode) {
    return []..add(alice.getDioInterceptor());
  }
  return [];
}

dynamic handleResponse(Response response) {
  if (response.isNotOk) {
    throw GMServerException(response.statusCode, response.statusMessage);
  }
  return response.data;
}
