import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gm_driver_lite/core/entity/model/models.dart';
import 'package:gm_driver_lite/core/utils/utils.dart';
import 'package:gm_driver_lite/core/extension/extensions.dart';

void main() {
  group('Stop Utils', () {
    test(
      '''WHEN generateNewStopKey is called
         SHOULD generate a new string for stop key with 30 length
      ''',
      () {
        final stopKey = generateNewStopKey();
        expect(stopKey is String, true);
        expect(stopKey.length, 30);
      },
    );

    test(
      '''WHEN generateCloneStopKey is called
         SHOULD generate a new string for stop key with the clone- substring
      ''',
      () {
        final cloneStopKey = generateCloneStopKey();
        expect(cloneStopKey is String, true);
        expect(cloneStopKey.contains('clone-'), true);
      },
    );

    test(
      '''WHEN cloneStopWithoutActuals is called
         SHOULD generate a new stop cloned without the actual values
      ''',
      () {
        final clonedStopKey = generateCloneStopKey();
        final cloneDate = DateTime.now().toUtcAsString;
        final actualArrival = DateTime.now().toUtcAsString;
        final actualDeparture = DateTime.now().toUtcAsString;
        final stop = StopModel(
          id: 1,
          key: '1',
          plannedSequenceNum: 1,
          actualArrival: actualArrival,
          actualDeparture: actualDeparture,
        );
        final clonedStop = cloneStopWithoutActuals(
          stopId: 2,
          stopKey: clonedStopKey,
          plannedSequenceNum: 2,
          stop: stop,
          cloneDate: cloneDate,
        );
        expect(clonedStop == stop, false);
        expect(clonedStop.actualArrival, isNull);
        expect(clonedStop.actualDeparture, isNull);
      },
    );

    test(
      '''WHEN getPendingStopStatusIconAsset is called
         SHOULD return the asset path to the equivalent stop icon
      ''',
      () {
        final stop = StopModel();
        final clonedStop = StopModel(
          cloneDate: DateTime.now().toUtcAsString,
        );
        final canceledStop = StopModel(
          canceled: true,
          cancelCode: CancelCodeModel(),
        );
        final redeliveredStop = StopModel(
          redelivered: true,
          redeliveryStop: StopModel(),
          undeliverableCode: UndeliverableCodeModel(),
        );
        final undeliveredStop = StopModel(
          undeliverableCode: UndeliverableCodeModel(),
        );

        final noIcon = getPendingStopStatusIconAsset(stop);
        final cloneIcon = getPendingStopStatusIconAsset(clonedStop);
        final cancelIcon = getPendingStopStatusIconAsset(canceledStop);
        final redeliverIcon = getPendingStopStatusIconAsset(redeliveredStop);
        final undeliverIcon = getPendingStopStatusIconAsset(undeliveredStop);

        expect(noIcon, '');
        expect(cloneIcon, 'assets/icons/stop-cloned.svg');
        expect(cancelIcon, 'assets/icons/canceled.svg');
        expect(redeliverIcon, 'assets/icons/redelivery.svg');
        expect(undeliverIcon, 'assets/icons/stop-undelivered.svg');
      },
    );

    test(
      '''WHEN getDoneStopStatusIconAsset is called
         SHOULD return the asset path to the equivalent stop icon
      ''',
      () {
        final stop = StopModel();
        final clonedStop = StopModel(
          cloneDate: DateTime.now().toUtcAsString,
        );
        final canceledStop = StopModel(
          canceled: true,
          cancelCode: CancelCodeModel(),
        );
        final redeliveredStop = StopModel(
          redelivered: true,
          redeliveryStop: StopModel(),
          undeliverableCode: UndeliverableCodeModel(),
        );
        final undeliveredStop = StopModel(
          undeliverableCode: UndeliverableCodeModel(),
        );

        final noIcon = getDoneStopStatusIconAsset(stop);
        final cloneIcon = getDoneStopStatusIconAsset(clonedStop);
        final cancelIcon = getDoneStopStatusIconAsset(canceledStop);
        final redeliverIcon = getDoneStopStatusIconAsset(redeliveredStop);
        final undeliverIcon = getDoneStopStatusIconAsset(undeliveredStop);

        expect(noIcon, '');
        expect(cloneIcon, 'assets/icons/cloned-stop.svg');
        expect(cancelIcon, 'assets/icons/canceled.svg');
        expect(redeliverIcon, 'assets/icons/redelivery.svg');
        expect(undeliverIcon, 'assets/icons/undeliverable.svg');
      },
    );

    test(
      '''WHEN getStopWidget is called
         SHOULD return the right widget to display
      ''',
      () {
        final stop = StopModel();
        final clonedStop = StopModel(
          cloneDate: DateTime.now().toUtcAsString,
        );

        final stopWidget = getStopWidget(
          isRouteFinished: false,
          stop: stop,
        );
        final stopWithRouteFinishedWidget = getStopWidget(
          isRouteFinished: true,
          stop: stop,
        );
        final stopClonedWidget = getStopWidget(
          isRouteFinished: false,
          stop: clonedStop,
        );

        expect(stopWidget is CircleAvatar, true);
        expect(stopWithRouteFinishedWidget is SvgPicture, true);
        expect(stopClonedWidget is SvgPicture, true);
      },
    );
  });

  test(
    '''WHEN getLocationInfo is called
       SHOULD return location key and description when location exists and '' otherwise
    ''',
    () {
      final stopWithoutLocation = StopModel();
      final stopWithLocation = StopModel(
        location: LocationModel(
          key: '1',
          description: 'description',
        ),
      );
      expect(getLocationInfo(stopWithoutLocation), '');
      expect(getLocationInfo(stopWithLocation), '1 - description');
    },
  );
}
