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
        if (stop.size1AliasConfig != null)
          StopSizeInfo(sizeAlias: stop.size1AliasConfig),
        const SizedBox(width: 8),
        if (stop.size2AliasConfig != null)
          StopSizeInfo(sizeAlias: stop.size2AliasConfig),
        const SizedBox(width: 8),
        if (stop.size3AliasConfig != null)
          StopSizeInfo(sizeAlias: stop.size3AliasConfig),
      ],
    );
  }
}
