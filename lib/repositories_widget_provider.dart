import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/repository/repositories_provider.dart';
import 'core/store/store.dart';

class RepositoriesWidgetProvider extends StatelessWidget {
  const RepositoriesWidgetProvider({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      key: UniqueKey(),
      providers: getRepositoryProviders(
        context.watch<Store>(),
      ),
      child: child,
    );
  }
}
