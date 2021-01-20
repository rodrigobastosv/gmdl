import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

import '../../../main.dart';
import '../../exception/exceptions.dart';
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
    /*..add(
        LogInterceptor(
          requestHeader: false,
          requestBody: false,
          responseHeader: false,
          responseBody: true,
          error: true,
        ),
      );*/
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

String getCriteria(dynamic criteria) {
  return jsonEncode(criteria);
}
