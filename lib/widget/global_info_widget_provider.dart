import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../core/global/global_info.dart';

class GlobalInfoWidgetProvider extends StatelessWidget {
  const GlobalInfoWidgetProvider({
    Key key,
    @required this.child,
    this.globalInfo,
  })  : assert(child != null),
        super(key: key);

  final Widget child;
  final GlobalInfo globalInfo;

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalInfo>(
      create: (_) => globalInfo ?? GlobalInfo(),
      child: child,
    );
  }
}
