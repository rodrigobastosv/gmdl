import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/utils.dart';
import '../../core/cubit/cubits.dart';
import 'gm_app.dart';

class GlobalCubitsListeners extends StatelessWidget {
  const GlobalCubitsListeners({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HosCubit, HosState>(
          listener: (context, state) async {
            if (state is LunchStarted) {
              await showLunchDialog(navigatorKey.currentContext);
            } else if (state is LunchEnded) {
              Navigator.of(navigatorKey.currentContext).pop();
            }
          },
        ),
      ],
      child: child,
    );
  }
}
