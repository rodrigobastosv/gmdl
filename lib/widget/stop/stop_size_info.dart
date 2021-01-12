import 'package:flutter/material.dart';

import '../../core/entity/model/models.dart';

class StopSizeInfo extends StatelessWidget {
  const StopSizeInfo({
    Key key,
    @required this.sizeAlias,
  })  : assert(sizeAlias != null),
        super(key: key);

  final BaseUnitModel sizeAlias;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 14,
          width: 14,
          color: const Color(0xFFB0D25A),
          child: const Center(
            child: Text(
              'S1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
        ),
        const SizedBox(width: 3),
        const Text('5'),
        const SizedBox(width: 3),
        Text(sizeAlias.description.toUpperCase()),
      ],
    );
  }
}
