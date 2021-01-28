import 'package:flutter/material.dart';

import '../../../core/extension/extensions.dart';

class StopListTileHeader extends StatelessWidget {
  const StopListTileHeader(
    this.label, {
    Key key,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          context.getTextUppercase(label),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
