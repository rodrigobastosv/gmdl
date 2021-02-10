import 'package:flutter/material.dart';

import '../../widget/alert/gm_loading_dialog.dart';
import '../../widget/core/gm_app.dart';
import '../extension/extensions.dart';

Future<void> showProOptimizingDialog(BuildContext context) async {
  showDialog(
    context: navigatorKey.currentContext,
    builder: (_) => GMLoadingDialog(
      message: context.getText('waitingrouteoptimization.popup.subtitle'),
    ),
  );
  await Future.delayed(const Duration(seconds: 5));
  Navigator.of(navigatorKey.currentContext).pop();
}
