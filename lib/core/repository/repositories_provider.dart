// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'client/utils.dart';
import 'loading_info_repository.dart';
import 'sign_in_repository.dart';

List<RepositoryProvider> getProviders() {
  return [
    RepositoryProvider<SignInRepository>(
      create: (_) => SignInRepository(
        getDefaultClient(),
      ),
    ),
    RepositoryProvider<LoadingInfoRepository>(
      create: (_) => LoadingInfoRepository(
        getDefaultClient(),
      ),
    ),
  ];
}
