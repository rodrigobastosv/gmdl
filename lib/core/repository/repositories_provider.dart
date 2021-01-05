import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../locator.dart';
import 'sign_in_repository.dart';

final providers = [
  RepositoryProvider<SignInRepository>(
    create: (_) => SignInRepository(
      G<Dio>(),
    ),
  ),
];
