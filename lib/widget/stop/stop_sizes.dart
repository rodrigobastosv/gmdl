import 'package:flutter/material.dart';

import '../../core/entity/model/models.dart';
import 'stop_size_info.dart';

class StopSizes extends StatelessWidget {
  const StopSizes({Key key, this.stop}) : super(key: key);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StopSizeInfo(sizeAlias: stop.size1AliasConfig),
        const SizedBox(width: 8),
        StopSizeInfo(sizeAlias: stop.size2AliasConfig),
        const SizedBox(width: 8),
        StopSizeInfo(sizeAlias: stop.size3AliasConfig),
      ],
    );
  }
}
