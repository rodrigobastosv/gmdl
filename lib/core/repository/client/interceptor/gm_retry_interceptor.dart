import 'package:dio/dio.dart';
import 'package:dio_retry/dio_retry.dart';

import '../client.dart';

class GMRetryInterceptor extends RetryInterceptor {
  GMRetryInterceptor(Dio dio)
      : super(
          dio: dio,
          options: const RetryOptions(
            retryInterval: Duration(seconds: DEFAULT_RETRY_INTERVAL_SECONDS),
            retries: DEFAULT_RETRIES_COUNT,
            retryEvaluator: getDefaultRetryPolicy,
          ),
        );
}
