import 'package:flutter/material.dart';

import '../../../core/extension/extensions.dart';

class StopListTileHeader extends StatelessWidget {
  const StopListTileHeader(
    this.label, {
    Key key,
    @required this.backgroundColor,
    @required this.textColor,
  }) : super(key: key);

  final String label;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          context.getTextUppercase(label),
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 12,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
