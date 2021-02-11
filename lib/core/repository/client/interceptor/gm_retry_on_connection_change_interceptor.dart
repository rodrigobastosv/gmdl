import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_retry/dio_retry.dart';
import 'package:flutter/foundation.dart';

import '../gm_connectivity_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  RetryOnConnectionChangeInterceptor({
    @required this.requestRetrier,
    @required this.retryOptions,
  });

  final GMConnectivityRetrier requestRetrier;
  final RetryOptions retryOptions;

  @override
  Future onError(DioError err) async {
    var extra = RetryOptions.fromExtra(err.request) ?? retryOptions;

    final shouldRetry = await extra.retryEvaluator(err);
    if (shouldRetry) {
      try {
        return requestRetrier.scheduleRequestRetry(err.request);
      } on Exception catch (error) {
        return error;
      }
    }
    return err;
  }
}
