import 'dart:async';

import 'package:dio/dio.dart';

class GMClient {
  GMClient(this._dio);

  final Dio _dio;

  Future<Response> get(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
  }) async {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
  }) async {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
