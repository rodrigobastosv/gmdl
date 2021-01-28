import 'package:flutter/material.dart';

import '../../core/entity/model/models.dart';
import 'stop_size_info.dart';

class StopSizes extends StatelessWidget {
  const StopSizes({
    Key key,
    @required this.stop,
    @required this.iconColor,
    @required this.textColor,
  }) : super(key: key);

  final StopModel stop;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (stop.size1AliasConfig != null)
          StopSizeInfo(
            sizeAlias: stop.size1AliasConfig,
            iconColor: iconColor,
            textColor: textColor,
          ),
        const SizedBox(width: 8),
        if (stop.size2AliasConfig != null)
          StopSizeInfo(
            sizeAlias: stop.size2AliasConfig,
            iconColor: iconColor,
            textColor: textColor,
          ),
        const SizedBox(width: 8),
        if (stop.size3AliasConfig != null)
          StopSizeInfo(
            sizeAlias: stop.size3AliasConfig,
            iconColor: iconColor,
            textColor: textColor,
          ),
      ],
    );
  }
}
