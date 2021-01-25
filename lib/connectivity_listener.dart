import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/cubit/cubits.dart';
import 'core/extension/i18n_cubit_extension.dart';
import 'widget/alert/notification.dart';

class ConnectivityListener extends StatelessWidget {
  const ConnectivityListener({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listener: (_, state) {
        if (state is HasConnection) {
          if (state.hasConnection) {
            showSuccessNotification(context.getText('loader.server.connected'));
          } else {
            showErrorNotification(context.getText('loader.server.unreachable'));
          }
        }
      },
      child: child,
    );
  }
}