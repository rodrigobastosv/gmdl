import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt G = GetIt.instance;

initLocator(String serverName) {
  G.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://$serverName.greenmile.com',
        queryParameters: {
          'consumer': 'DRIVER',
        },
      ),
    ),
  );
}
