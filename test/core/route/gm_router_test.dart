import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/core/entity/model/models.dart';
import 'package:gm_driver_lite/core/route/gm_router.dart';
import 'package:gm_driver_lite/core/route/route.dart';
import '../../setup_firebase.dart';
import 'mock_data.dart';

void main() {
  setupFirebaseForTesting();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
  });

  group('GMRouter', () {
    test('INITIAL_SETTINGS_PAGE', () {
      final route = GMRouter.generateRoutes(
        const RouteSettings(
          name: INITIAL_SETTINGS_PAGE,
        ),
      );
      final matchedRoute = route as CupertinoPageRoute;
      expect(matchedRoute.settings.name, INITIAL_SETTINGS_PAGE);
    });

    test('LOAD_INFO_PAGE', () {
      final route = GMRouter.generateRoutes(
        const RouteSettings(
          name: LOAD_INFO_PAGE,
          arguments: 'username',
        ),
      );
      final matchedRoute = route as CupertinoPageRoute;
      expect(matchedRoute.settings.name, LOAD_INFO_PAGE);
    });

    test('CHOOSE_EQUIPMENT_PAGE', () {
      final route = GMRouter.generateRoutes(
        const RouteSettings(
          name: CHOOSE_EQUIPMENT_PAGE,
        ),
      );
      final matchedRoute = route as CupertinoPageRoute;
      expect(matchedRoute.settings.name, CHOOSE_EQUIPMENT_PAGE);
    });

    test('LOAD_ROUTE_PAGE', () {
      final route = GMRouter.generateRoutes(
        const RouteSettings(
          name: LOAD_ROUTE_PAGE,
        ),
      );
      final matchedRoute = route as CupertinoPageRoute;
      expect(matchedRoute.settings.name, LOAD_ROUTE_PAGE);
    });

    test('ROUTE_AT_GLANCE_PAGE', () {
      final route = GMRouter.generateRoutes(
        RouteSettings(
          name: ROUTE_AT_GLANCE_PAGE,
          arguments: RouteModel(),
        ),
      );
      final matchedRoute = route as CupertinoPageRoute;
      expect(matchedRoute.settings.name, ROUTE_AT_GLANCE_PAGE);
    });

    test('ROUTE_SUMMARY_PAGE', () {
      final route = GMRouter.generateRoutes(
        RouteSettings(
          name: ROUTE_SUMMARY_PAGE,
          arguments: routeCubit,
        ),
      );
      final matchedRoute = route as CupertinoPageRoute;
      expect(matchedRoute.settings.name, ROUTE_SUMMARY_PAGE);
    });

    test('SIGN_IN_PAGE', () {
      final route = GMRouter.generateRoutes(
        const RouteSettings(
          name: SIGN_IN_PAGE,
        ),
      );
      final matchedRoute = route as CupertinoPageRoute;
      expect(matchedRoute.settings.name, SIGN_IN_PAGE);
    });

    test('STOP_PAGE', () {
      final route = GMRouter.generateRoutes(
        RouteSettings(
          name: STOP_PAGE,
          arguments: stopPageArguments,
        ),
      );
      final matchedRoute = route as CupertinoPageRoute;
      expect(matchedRoute.settings.name, STOP_PAGE);
    });

    test('CHOOSE_CANCEL_CODE_PAGE', () {
      final route = GMRouter.generateRoutes(
        RouteSettings(
          name: CHOOSE_CANCEL_CODE_PAGE,
          arguments: stopCubit,
        ),
      );
      final matchedRoute = route as CupertinoPageRoute;
      expect(matchedRoute.settings.name, CHOOSE_CANCEL_CODE_PAGE);
    });

    test('CHOOSE_REDELIVER_CODE_PAGE', () {
      final route = GMRouter.generateRoutes(
        RouteSettings(
          name: CHOOSE_REDELIVER_CODE_PAGE,
          arguments: stopCubit,
        ),
      );
      final matchedRoute = route as CupertinoPageRoute;
      expect(matchedRoute.settings.name, CHOOSE_REDELIVER_CODE_PAGE);
    });

    test('CHOOSE_UNDELIVERABLE_CODE_PAGE', () {
      final route = GMRouter.generateRoutes(
        RouteSettings(
          name: CHOOSE_UNDELIVERABLE_CODE_PAGE,
          arguments: stopCubit,
        ),
      );
      final matchedRoute = route as CupertinoPageRoute;
      expect(matchedRoute.settings.name, CHOOSE_UNDELIVERABLE_CODE_PAGE);
    });

    test('STOP_LIST_PAGE', () {
      final route = GMRouter.generateRoutes(
        RouteSettings(
          name: STOP_LIST_PAGE,
          arguments: routeCubit,
        ),
      );
      final matchedRoute = route as CupertinoPageRoute;
      expect(matchedRoute.settings.name, STOP_LIST_PAGE);
    });

    test('FINISHED_STOPS_PAGE', () {
      final route = GMRouter.generateRoutes(
        RouteSettings(
          name: FINISHED_STOPS_PAGE,
          arguments: routeCubit,
        ),
      );
      final matchedRoute = route as CupertinoPageRoute;
      expect(matchedRoute.settings.name, FINISHED_STOPS_PAGE);
    });

    test('DEFAULT', () {
      final route = GMRouter.generateRoutes(
        const RouteSettings(
          name: 'DEFAULT',
        ),
      );
      final matchedRoute = route as CupertinoPageRoute;
      expect(matchedRoute.settings.name, 'DEFAULT');
    });
  });
}
