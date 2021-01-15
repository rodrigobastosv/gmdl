import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import '../../exception/exceptions.dart';

import '../../../main.dart';
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

Dio getDefaultClient(String serverName, String sessionId) {
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
    throw GMServerException(response.statusMessage);
  }
  return response.data;
}

String getErrorMessage(DioError dioError) {
  return dioError.response.data['message'];
}
