import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/core/entity/model/route_model.dart';
import 'package:gm_driver_lite/core/entity/model/stop_model.dart';
import 'package:gm_driver_lite/core/extension/extensions.dart';
import 'package:gm_driver_lite/core/utils/utils.dart';

void main() {
  final routePlannedDeparture = DateTime.now().toUtcAsString;
  final routePlannedArrival =
      DateTime.now().add(const Duration(hours: 7, minutes: 30)).toUtcAsString;
  final stopActualDeparture = DateTime.now().toUtcAsString;

  final routeWithPendingAndDoneStops = RouteModel(
    id: 1,
    plannedDistance: 30000,
    plannedDeparture: routePlannedDeparture,
    plannedArrival: routePlannedArrival,
    stops: [
      StopModel(
        id: 1,
        key: '1',
        plannedSequenceNum: 1,
      ),
      StopModel(
        id: 2,
        key: '2',
        plannedSequenceNum: 2,
      ),
      StopModel(
        id: 3,
        key: '3',
        plannedSequenceNum: 3,
      ),
      StopModel(
        id: 5,
        key: '5',
        plannedSequenceNum: 5,
        actualDeparture: stopActualDeparture,
      ),
      StopModel(
        id: 4,
        key: '4',
        plannedSequenceNum: 4,
        actualDeparture: stopActualDeparture,
      ),
    ],
  );

  final routeWithNoPendingStops = RouteModel(
    id: 2,
    stops: [
      StopModel(
        id: 1,
        key: '1',
        plannedSequenceNum: 1,
        actualDeparture: stopActualDeparture,
      ),
      StopModel(
        id: 2,
        key: '2',
        plannedSequenceNum: 2,
        actualDeparture: stopActualDeparture,
      ),
      StopModel(
        id: 3,
        key: '3',
        plannedSequenceNum: 3,
        actualDeparture: stopActualDeparture,
      ),
      StopModel(
        id: 5,
        key: '5',
        plannedSequenceNum: 5,
        actualDeparture: stopActualDeparture,
      ),
      StopModel(
        id: 4,
        key: '4',
        plannedSequenceNum: 4,
        actualDeparture: stopActualDeparture,
      ),
    ],
  );

  group('Route selectors', () {
    test(
      '''WHEN getPendingStops is called
         SHOULD return all stops that are pending
      ''',
      () {
        final pendingStops = getPendingStops(routeWithPendingAndDoneStops);
        expect(
          pendingStops,
          [
            StopModel(
              id: 1,
              key: '1',
              plannedSequenceNum: 1,
            ),
            StopModel(
              id: 2,
              key: '2',
              plannedSequenceNum: 2,
            ),
            StopModel(
              id: 3,
              key: '3',
              plannedSequenceNum: 3,
            ),
          ],
        );
      },
    );

    test(
      '''WHEN getDoneStops is called
         SHOULD return all stops that are done
      ''',
      () {
        final pendingStops = getDoneStops(routeWithPendingAndDoneStops);
        expect(
          pendingStops,
          [
            StopModel(
              id: 5,
              key: '5',
              plannedSequenceNum: 5,
              actualDeparture: stopActualDeparture,
            ),
            StopModel(
              id: 4,
              key: '4',
              plannedSequenceNum: 4,
              actualDeparture: stopActualDeparture,
            ),
          ],
        );
      },
    );

    test(
      '''WHEN getStopsOrderedByPlannedSequenceNum is called
         SHOULD return all stops ordered by plannedSequenceNum
      ''',
      () {
        final stopsOrdered = getStopsOrderedByPlannedSequenceNum(
            routeWithPendingAndDoneStops.stops);
        expect(
          stopsOrdered,
          [
            StopModel(
              id: 1,
              key: '1',
              plannedSequenceNum: 1,
            ),
            StopModel(
              id: 2,
              key: '2',
              plannedSequenceNum: 2,
            ),
            StopModel(
              id: 3,
              key: '3',
              plannedSequenceNum: 3,
            ),
            StopModel(
              id: 4,
              key: '4',
              plannedSequenceNum: 4,
              actualDeparture: stopActualDeparture,
            ),
            StopModel(
              id: 5,
              key: '5',
              plannedSequenceNum: 5,
              actualDeparture: stopActualDeparture,
            ),
          ],
        );
      },
    );

    test(
      '''WHEN getNextSuggestedStop is called
         SHOULD return the next stop suggestion
      ''',
      () {
        final stopSuggested =
            getNextSuggestedStop(routeWithPendingAndDoneStops);
        expect(
          stopSuggested,
          StopModel(
            id: 1,
            key: '1',
            plannedSequenceNum: 1,
          ),
        );
      },
    );

    test(
      '''WHEN hasPendingStops is called
         SHOULD return true if route has pending stops and false otherwise
      ''',
      () {
        expect(hasPendingStops(routeWithPendingAndDoneStops), true);
        expect(hasPendingStops(routeWithNoPendingStops), false);
      },
    );

    test(
      '''WHEN getPlannedDistanceInKm is called
         SHOULD return the planned distance converted to Km
      ''',
      () {
        expect(getPlannedDistanceInKm(routeWithPendingAndDoneStops), 30);
      },
    );

    test(
      '''WHEN getPlannedServiceInHoursAndMinutes is called
         SHOULD calculate and return the planned service formatted in hours and minutes
      ''',
      () {
        final plannedService =
            getPlannedServiceInHoursAndMinutes(routeWithPendingAndDoneStops);
        expect(plannedService, '7h 30m');
      },
    );

    test(
      '''WHEN getLastStopOrderedById is called
         SHOULD return the stop with greater id
      ''',
      () {
        final lastStopById =
            getLastStopOrderedById(routeWithPendingAndDoneStops);
        expect(
          lastStopById,
          StopModel(
            id: 5,
            key: '5',
            plannedSequenceNum: 5,
            actualDeparture: stopActualDeparture,
          ),
        );
      },
    );

    test(
      '''WHEN getLastPlannedStop is called
         SHOULD return the stop that is planned to be visited lastly
      ''',
      () {
        final lastPlannedStop =
            getLastPlannedStop(routeWithPendingAndDoneStops);
        expect(
          lastPlannedStop,
          StopModel(
            id: 5,
            key: '5',
            plannedSequenceNum: 5,
            actualDeparture: stopActualDeparture,
          ),
        );
      },
    );
  });
}
