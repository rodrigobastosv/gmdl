import 'package:flutter/material.dart';

import '../../core/entity/model/models.dart';

class StopSizeInfo extends StatelessWidget {
  const StopSizeInfo({
    Key key,
    @required this.sizeAlias,
    @required this.iconColor,
    @required this.textColor,
  })  : assert(sizeAlias != null),
        super(key: key);

  final BaseUnitModel sizeAlias;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 14,
          width: 14,
          color: iconColor,
          child: Center(
            child: Text(
              'S1',
              style: TextStyle(
                fontSize: 10,
                color: textColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 3),
        Text(
          '5',
          style: TextStyle(
            color: textColor,
          ),
        ),
        const SizedBox(width: 3),
        Text(
          sizeAlias.description.toUpperCase(),
          style: TextStyle(
            color: textColor,
          ),
        ),
      ],
    );
  }
}
