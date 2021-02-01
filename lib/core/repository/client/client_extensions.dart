import 'package:dio/dio.dart';

import 'http_constants.dart';

extension ResponseExt on Response {
  bool get isOk => statusCode == HTTP_OK;
  bool get isNotOk => statusCode != HTTP_OK;
  bool get isPrecondictionFailed => statusCode == HTTP_PRECONDICTION_FAILED;
}
