import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../main.dart';

GetIt G = GetIt.instance;

initLocator(String serverName) {
  G.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        headers: {
          'Accept': 'application/json',
        },
        baseUrl: 'https://$serverName.greenmile.com',
        queryParameters: {
          'consumer': 'DRIVER',
        },
      ),
    )..interceptors.add(alice.getDioInterceptor()),
  );
}
