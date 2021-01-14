import 'package:flutter/foundation.dart';
import '../entity/model/models.dart';

import 'utils.dart';

String generateCloneStopKey() {
  return 'clone-${generateRandomString(30)}';
}

StopModel cloneStopWithoutActuals({
  @required int stopId,
  @required String stopKey,
  @required StopModel stop,
  @required int plannedSequenceNum,
}) {
  return stop.copyWith(
    id: stopId,
    key: stopKey,
    plannedSequenceNum: plannedSequenceNum,
    actualArrival: null,
    actualDeparture: null,
  );
}
