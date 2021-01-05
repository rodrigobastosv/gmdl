import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gm_driver_lite/core/repository/driver_info_repository.dart';

import '../locator.dart';
import 'sign_in_repository.dart';

List<RepositoryProvider> getProviders(String sessionId) {
  if (sessionId != null) {
    G<Dio>().options.headers = {
      'Cookie': 'SESSION=$sessionId',
    };
  }
  print(G<Dio>().options);
  print(G<Dio>().options.headers);
  return [
    RepositoryProvider<SignInRepository>(
      create: (_) => SignInRepository(
        G<Dio>(),
      ),
    ),
    RepositoryProvider<DriverInfoRepository>(
      create: (_) => DriverInfoRepository(
        G<Dio>(),
      ),
    ),
  ];
}
