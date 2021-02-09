import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/entity/model/models.dart';
import '../../stop_list/widget/stop_list_tile.dart';

class MapStopListTile extends StopListTile {
  MapStopListTile({
    Key key,
    @required StopModel stop,
    bool isNextStopSuggested = false,
    bool isBeginNextStops = false,
  })  : assert(stop != null),
        super(
            key: key,
            stop: stop,
            isUsingPro: true,
            isNextStopSuggested: isNextStopSuggested,
            isBeginNextStops: isBeginNextStops,
            headerBackgroundColor: const Color(0xFF3AA348),
            headerTextColor: Colors.white);
}
