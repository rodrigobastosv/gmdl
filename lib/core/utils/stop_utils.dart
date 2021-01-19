import 'package:flutter/foundation.dart';

import '../entity/model/models.dart';
import 'utils.dart';

String generateNewStopKey() => generateRandomString(30);

String generateCloneStopKey() => 'clone-${generateRandomString(30)}';

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

String getPendingStopStatusIconAsset(StopModel stop) {
  if (stop.isCloned) {
    return 'assets/icons/stop-cloned.svg';
  } else if (stop.isCanceled) {
    return 'assets/icons/canceled.svg';
  } else if (stop.isRedelivered) {
    return 'assets/icons/redeliver.svg';
  } else if (stop.isUndeliverable) {
    return 'assets/icons/stop-undelivered.svg';
  }
  return '';
}

String getDoneStopStatusIconAsset(StopModel stop) {
  if (stop.isCloned) {
    return 'assets/icons/cloned-stop.svg';
  } else if (stop.isCanceled) {
    return 'assets/icons/canceled.svg';
  } else if (stop.isRedelivered) {
    return 'assets/icons/redeliver.svg';
  } else if (stop.isUndeliverable) {
    return 'assets/icons/undeliverable.svg';
  }
  return '';
}
