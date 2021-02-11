import 'package:flutter/material.dart';

import '../../core/extension/extensions.dart';
import '../general/gm_menu_option.dart';

class CancelStopMenuItem extends StatelessWidget {
  const CancelStopMenuItem({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GMMenuOption(
      text: context.getText('stop.cancel'),
      icon: 'cancel-stop',
      onTap: onTap,
    );
  }
}
