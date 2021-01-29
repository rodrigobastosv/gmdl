import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class GMLoggerInterceptor extends PrettyDioLogger {
  GMLoggerInterceptor()
      : super(
          request: false,
        );
}
