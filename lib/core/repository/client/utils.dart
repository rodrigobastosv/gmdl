import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dio_retry/dio_retry.dart';
import 'package:hive/hive.dart';

import '../../../main.dart';
import '../../constants.dart';
import '../../exception/exceptions.dart';
import '../../global/hive.dart';
import 'client.dart';
import 'gm_connectivity_retrier.dart';
import 'http_constants.dart';
import 'interceptor/gm_retry_interceptor.dart';
import 'interceptor/interceptors.dart';

const DEFAULT_RETRIES_COUNT = 2;
const DEFAULT_RETRY_INTERVAL_SECONDS = 1;
const DEFAULT_RETRY_OPTIONS = RetryOptions(
  retryInterval: Duration(seconds: DEFAULT_RETRY_INTERVAL_SECONDS),
  retries: DEFAULT_RETRIES_COUNT,
  retryEvaluator: getDefaultRetryPolicy,
);

const QUEUE_RETRIES_COUNT = 5;
const QUEUE_RETRY_INTERVAL_SECONDS = 60;
const QUEUE_RETRY_OPTIONS = RetryOptions(
  retryInterval: Duration(seconds: QUEUE_RETRY_INTERVAL_SECONDS),
  retries: QUEUE_RETRIES_COUNT,
  retryEvaluator: getQueueRetryPolicy,
);

const CONNECTIVITY_RETRY_OPTIONS = RetryOptions(
  retryInterval: Duration(seconds: DEFAULT_RETRY_INTERVAL_SECONDS),
  retries: DEFAULT_RETRIES_COUNT,
  retryEvaluator: getConnectivityRetryPolicy,
);

FutureOr<bool> getDefaultRetryPolicy(DioError error) {
  final method = error.request.method;
  final url = error.request.path;
  final statusCode = error.response?.statusCode;
  return method != HTTP_METHOD_DELETE &&
      statusCode != HTTP_FORBIDDEN &&
      (method != HTTP_METHOD_POST ||
          url.contains(RESTRICTIONS) ||
          isStopActionRequest(url));
}

FutureOr<bool> getConnectivityRetryPolicy(DioError error) {
  return error.type == DioErrorType.DEFAULT &&
      error.error != null &&
      (error.error is SocketException || error.error is TimeoutException);
}

FutureOr<bool> getQueueRetryPolicy(DioError error) {
  final method = error.request.method;
  final url = error.request.path;
  final statusCode = error.response?.statusCode;
  return method != HTTP_METHOD_DELETE &&
      statusCode != HTTP_FORBIDDEN &&
      (method != HTTP_METHOD_POST ||
          url.contains(RESTRICTIONS) ||
          isStopActionRequest(url));
}

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
  dio.interceptors.addAll(_getInterceptors(dio));
  return dio;
}

Dio getBasicTestClient() {
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
  dio.interceptors.addAll(_getInterceptors(dio));
  return dio;
}

Dio getDefaultTestClient(String serverName, String sessionId) {
  final dio = Dio(
    BaseOptions(
      headers: {
        ACCEPT: APPLICATION_JSON,
        COOKIE: '$SESSION=$sessionId',
      },
      baseUrl: 'https://$serverName.greenmile.com',
      queryParameters: {
        CONSUMER: 'LIVE',
      },
    ),
  );
  return dio;
}

Dio getQueueClient(String serverName, String sessionId) {
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
  dio.interceptors.addAll(_getQueueInterceptors(dio));
  return dio;
}

List<Interceptor> _getInterceptors(Dio dio) {
  return [
    if (kDebugMode) ...[
      alice.getDioInterceptor(),
    ],
    GMRetryInterceptor(
      dio: dio,
      retryOptions: DEFAULT_RETRY_OPTIONS,
    ),
    RetryOnConnectionChangeInterceptor(
      requestRetrier: GMConnectivityRetrier(
        dio: dio,
        connectivity: Connectivity(),
      ),
      retryOptions: CONNECTIVITY_RETRY_OPTIONS,
    ),
    GMAuthInterceptor(
      dio: dio,
      globalBox: Hive.box(GLOBAL_BOX),
    ),
  ];
}

List<Interceptor> _getQueueInterceptors(Dio dio) {
  return [
    if (kDebugMode) ...[
      alice.getDioInterceptor(),
    ],
    GMRetryInterceptor(
      dio: dio,
      retryOptions: QUEUE_RETRY_OPTIONS,
    ),
    RetryOnConnectionChangeInterceptor(
      requestRetrier: GMConnectivityRetrier(
        dio: dio,
        connectivity: Connectivity(),
      ),
      retryOptions: CONNECTIVITY_RETRY_OPTIONS,
    ),
    GMAuthInterceptor(
      dio: dio,
      globalBox: Hive.box(GLOBAL_BOX),
    ),
  ];
}

bool isStopActionRequest(String url) {
  return url.contains(ROUTE) && url.contains(STOP);
}

dynamic handleResponse(Response response) {
  if (response.isNotOk && response.statusCode != HTTP_FORBIDDEN) {
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
