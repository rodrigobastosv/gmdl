import 'package:flutter/material.dart';

import '../../core/extension/extensions.dart';
import '../general/gm_menu_option.dart';

class UndeliverStopMenuItem extends StatelessWidget {
  const UndeliverStopMenuItem({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GMMenuOption(
      text: context.getText('status.undeliverable'),
      icon: 'undeliver',
      onTap: onTap,
    );
  }
}
