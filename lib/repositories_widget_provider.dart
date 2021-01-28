import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/global/hive.dart';
import 'core/repository/repositories_provider.dart';

class RepositoriesWidgetProvider extends StatelessWidget {
  const RepositoriesWidgetProvider({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box(GLOBAL_BOX).listenable(),
      builder: (_, box, ___) => MultiRepositoryProvider(
        key: UniqueKey(),
        providers: getRepositoryProviders(box),
        child: child,
      ),
    );
  }
}
