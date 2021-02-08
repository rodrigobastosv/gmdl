import 'package:dio/dio.dart';
import 'package:dio_retry/dio_retry.dart';

import '../client.dart';

/// This interceptor is called on all failed request and retry the request based
/// on the `DefaultRetryPolicy`.
class GMRetryInterceptor extends Interceptor {
  GMRetryInterceptor(this.dio);

  final Dio dio;
  final retryOptions = const RetryOptions(
    retryInterval: Duration(seconds: DEFAULT_RETRY_INTERVAL_SECONDS),
    retries: DEFAULT_RETRIES_COUNT,
    retryEvaluator: getDefaultRetryPolicy,
  );

  @override
  Future onError(DioError err) async {
    var extra = RetryOptions.fromExtra(err.request) ?? retryOptions;

    final shouldRetry = extra.retries > 0 && await extra.retryEvaluator(err);
    if (shouldRetry) {
      if (extra.retryInterval.inMilliseconds > 0) {
        await Future.delayed(extra.retryInterval);
      }

      extra = extra.copyWith(retries: extra.retries - 1);
      err.request.extra = err.request.extra..addAll(extra.toExtra());

      try {
        return await dio.request(
          err.request.path,
          cancelToken: err.request.cancelToken,
          data: err.request.data,
          onReceiveProgress: err.request.onReceiveProgress,
          onSendProgress: err.request.onSendProgress,
          queryParameters: err.request.queryParameters,
          options: err.request,
        );
      } on DioError catch (error) {
        extra = extra.copyWith(retries: extra.retries - 1);
        err.request.extra = err.request.extra..addAll(extra.toExtra());

        return await dio.request(
          error.request.path,
          cancelToken: error.request.cancelToken,
          data: error.request.data,
          onReceiveProgress: error.request.onReceiveProgress,
          onSendProgress: error.request.onSendProgress,
          queryParameters: error.request.queryParameters,
          options: error.request,
        );
      }
    }
    return super.onError(err);
  }
}
