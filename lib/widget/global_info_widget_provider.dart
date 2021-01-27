import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../core/global/global_info.dart';

class GlobalInfoWidgetProvider extends StatelessWidget {
  const GlobalInfoWidgetProvider({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalInfo>(
      create: (_) => GlobalInfo(),
      child: child,
    );
  }
}
