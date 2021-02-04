import 'package:gm_driver_lite/core/entity/model/models.dart';
import 'package:gm_driver_lite/core/extension/extensions.dart';

final actualArrivalStop = DateTime.now().toUtcAsString;
final actualDepartureStop = DateTime.now().toUtcAsString;
final cloneDateStop = DateTime.now().toUtcAsString;
final actualCancelStop = DateTime.now().toUtcAsString;

final stopToArrival = StopModel(
  id: 1,
  key: 'key',
);

final routeWithOneStop = RouteModel(
  id: 1,
  stops: [
    stopToArrival,
  ],
);

final routeWithTwoStop = RouteModel(
  id: 1,
  stops: [
    StopModel(
      id: 1,
      key: 'key1',
      plannedSequenceNum: 1,
    ),
    StopModel(
      id: 2,
      key: 'key2',
      plannedSequenceNum: 2,
    ),
  ],
);

final clonedStop = StopModel(
  id: 2,
  key: 'clone-key',
  plannedSequenceNum: 2,
);
