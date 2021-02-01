import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

import '../../../main.dart';
import '../../constants.dart';
import '../../exception/exceptions.dart';
import 'client.dart';
import 'http_constants.dart';
import 'interceptor/gm_retry_interceptor.dart';
import 'interceptor/interceptors.dart';

const DEFAULT_RETRIES_COUNT = 2;
const DEFAULT_RETRY_INTERVAL_SECONDS = 5;

Dio getBasicClient() {
  final dio = Dio(
    BaseOptions(
      headers: {
        ACCEPT: APPLICATION_JSON,
      },
      queryParameters: {
        CONSUMER: consumer,
      },
    ),
  );
  dio.interceptors.addAll(_getBasicInterceptors(dio));
  return dio;
}

Dio getDefaultClient(String serverName, String sessionId) {
  final dio = Dio(
    BaseOptions(
      headers: {
        ACCEPT: APPLICATION_JSON,
        COOKIE: '$SESSION=$sessionId',
      },
      baseUrl: 'https://$serverName.greenmile.com',
      queryParameters: {
        CONSUMER: consumer,
      },
    ),
  );
  dio.interceptors.addAll(_getBasicInterceptors(dio));
  return dio;
}

List<Interceptor> _getBasicInterceptors(Dio dio) {
  return [
    if (kDebugMode) ...[
      alice.getDioInterceptor(),
    ],
    GMRetryInterceptor(dio),
  ];
}

FutureOr<bool> getDefaultRetryPolicy(DioError error) {
  final method = error.request.method;
  final url = error.request.path;
  return method != HTTP_METHOD_DELETE &&
      (method != HTTP_METHOD_POST || url.contains(RESTRICTIONS));
}

dynamic handleResponse(Response response) {
  if (response.isNotOk) {
    throw GMServerException(response.statusMessage);
  }
  return response.data;
}

String getErrorMessage(DioError dioError) {
  if (dioError.response.statusCode == HTTP_NOT_FOUND) {
    return 'loader.server.connectivity';
  }
  return dioError.response.data['message'] ??
      dioError.response.data['errorMessages'][0]['resource']['value'];
}

String getCriteria(dynamic criteria) {
  return jsonEncode(criteria);
}
