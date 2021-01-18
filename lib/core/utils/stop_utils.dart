import 'package:flutter/foundation.dart';

import '../entity/model/models.dart';
import 'utils.dart';

bool isPendingStop(StopModel stop) =>
    stop.actualDeparture == null && !stop.canceled && !stop.isUndeliverable;

bool isDoneStop(StopModel stop) => !isPendingStop(stop);

String generateCloneStopKey() {
  return 'clone-${generateRandomString(30)}';
}

StopModel cloneStopWithoutActuals({
  @required int stopId,
  @required String stopKey,
  @required String cloneDate,
  @required StopModel stop,
  @required int plannedSequenceNum,
}) {
  return stop.copyWith(
    id: stopId,
    key: stopKey,
    plannedSequenceNum: plannedSequenceNum,
    cloneDate: cloneDate,
    actualArrival: null,
    actualDeparture: null,
  );
}
