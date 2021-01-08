import 'package:dio/dio.dart';

import 'http_status.dart';

extension ResponseExt on Response {
  bool get isOk => statusCode == HTTP_OK;
  bool get isNotOk => statusCode != HTTP_OK;
}
