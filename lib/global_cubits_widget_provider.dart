import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'connectivity_listener.dart';
import 'core/cubit/global_cubits.dart';

class GlobalCubitsWidgetProvider extends StatelessWidget {
  const GlobalCubitsWidgetProvider({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: getGlobalCubits(context),
      child: ConnectivityListener(child: child),
    );
  }
}
