import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

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
      cancelCode: null,
      undeliverableCode: null,
      redeliveryStop: null);
}

String getPendingStopStatusIconAsset(StopModel stop) {
  if (stop.isCloned) {
    return 'assets/icons/stop-cloned.svg';
  } else if (stop.isCanceled) {
    return 'assets/icons/canceled.svg';
  } else if (stop.isRedelivered) {
    return 'assets/icons/redelivery.svg';
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
    return 'assets/icons/redelivery.svg';
  } else if (stop.isUndeliverable) {
    return 'assets/icons/undeliverable.svg';
  }
  return '';
}

Widget getStopWidget({
  bool isRouteFinished,
  StopModel stop,
}) {
  if (stop.stopHadActionPerformed) {
    return SvgPicture.asset(
      getDoneStopStatusIconAsset(stop),
      height: 32,
      width: 32,
    );
  } else {
    if (isRouteFinished) {
      return SvgPicture.asset(
        'assets/icons/circled-checkmark.svg',
        height: 32,
        width: 32,
      );
    }
    return CircleAvatar(
      backgroundColor: const Color(0xFF464646),
      child: Text(
        stop.plannedSequenceNum?.toString() ?? '',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

String getLocationInfo(StopModel stop) {
  if (stop.location == null) {
    return '';
  }
  return '${stop.location.key ?? ''} - ${stop.location.description ?? ''}';
}

int getStopServiceTimeInSeconds(StopModel stop) {
  if (stop.hasNotBeenArrived) {
    return 0;
  } else if (stop.isPending) {
    final actualArrival = DateTime.parse(stop.actualArrival);
    final now = DateTime.now();
    final difference = now.difference(actualArrival);
    return difference.inSeconds;
  } else {
    final actualArrival = DateTime.parse(stop.actualArrival);
    final actualDeparture = DateTime.parse(stop.actualDeparture);
    final difference = actualDeparture.difference(actualArrival);
    return difference.inSeconds;
  }
}
