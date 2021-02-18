import 'dart:async';

import 'package:dio/dio.dart';
import 'package:queue/queue.dart';

import 'client.dart';

class GMClient {
  String username;
  String password;
  String serverName;
  String sessionId;

  final queue = Queue();

  void init({
    String username,
    String password,
    String serverName,
    String sessionId,
  }) {
    this.username = username;
    this.password = password;
    this.serverName = serverName;
    this.sessionId = sessionId;
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
  }) async {
    final _client = getDefaultClient(serverName, sessionId);
    return await _client.get(
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
    final _client = getDefaultClient(serverName, sessionId);
    return await _client.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<void> postQueued(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
  }) async {
    final _client = getQueueClient(serverName, sessionId);
    try {
      queue.add(
        () => _client.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ),
      );
    } on Exception {
      rethrow;
    }
  }
}
