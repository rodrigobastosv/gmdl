import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/page/choose_equipment/choose_equipment_page.dart';
import 'package:gm_driver_lite/page/pages.dart';
import '../constants.dart';
import '../mocks.dart';
import '../setup/setups.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async => await setupForWidgetTesting());

  group('ChooseEquipmentPage', () {
    MockChooseEquipmentCubit mockChooseEquipmentCubit;

    setUp(() {
      mockChooseEquipmentCubit = MockChooseEquipmentCubit();
    });

    testWidgets('should build without exploding', (tester) async {
      await tester.pumpWidget(
        connectedWidgetForTesting(
          child: BlocProvider<ChooseEquipmentCubit>(
            create: (_) => mockChooseEquipmentCubit,
            child: ChooseEquipmentPage(),
          ),
        ),
      );
    });

    testWidgets(
      '''WHEN state is EquipmentFound
           SHOULD navigate to LOAD_ROUTE_PAGE route
        ''',
      (tester) async {
        final mockNavigatorObserver = MockNavigatorObserver();
        whenListen(
          mockChooseEquipmentCubit,
          Stream.fromIterable(
            [
              EquipmentFound(),
            ],
          ),
        );
        await tester.pumpWidget(
          connectedWidgetForTesting(
            child: BlocProvider<ChooseEquipmentCubit>(
              create: (_) => mockChooseEquipmentCubit,
              child: ChooseEquipmentPage(),
            ),
            mockNavigatorObserver: mockNavigatorObserver,
          ),
        );
        await tester.pump();
        verify(mockNavigatorObserver.didPush(any, any));
      },
    );

    testWidgets(
      '''WHEN state is EquipmentNotFound
         SHOULD show error notification
      ''',
      (tester) async {
        final mockNavigatorObserver = MockNavigatorObserver();
        whenListen(
          mockChooseEquipmentCubit,
          Stream.fromIterable(
            [
              EquipmentNotFound('error'),
            ],
          ),
        );
        await tester.pumpWidget(
          connectedWidgetForTesting(
            child: BlocProvider<ChooseEquipmentCubit>(
              create: (_) => mockChooseEquipmentCubit,
              child: ChooseEquipmentPage(),
            ),
            mockNavigatorObserver: mockNavigatorObserver,
          ),
        );
        await tester.pump();
        expect(find.text('error'), findsOneWidget);
        await tester.pumpAndSettle(alertDuration);
      },
    );

    testWidgets(
      '''WHEN state is EquipmentFailed
         SHOULD show error notification
      ''',
      (tester) async {
        final mockNavigatorObserver = MockNavigatorObserver();
        whenListen(
          mockChooseEquipmentCubit,
          Stream.fromIterable(
            [
              EquipmentFailed('error'),
            ],
          ),
        );
        await tester.pumpWidget(
          connectedWidgetForTesting(
            child: BlocProvider<ChooseEquipmentCubit>(
              create: (_) => mockChooseEquipmentCubit,
              child: ChooseEquipmentPage(),
            ),
            mockNavigatorObserver: mockNavigatorObserver,
          ),
        );
        await tester.pump();
        expect(find.text('error'), findsOneWidget);
        await tester.pumpAndSettle(alertDuration);
      },
    );

    testWidgets(
      '''WHEN state is LoadingEquipment
         SHOULD show loading
      ''',
      (tester) async {
        final mockNavigatorObserver = MockNavigatorObserver();
        when(mockChooseEquipmentCubit.state).thenReturn(LoadingEquipment());
        await tester.pumpWidget(
          connectedWidgetForTesting(
            child: BlocProvider<ChooseEquipmentCubit>(
              create: (_) => mockChooseEquipmentCubit,
              child: ChooseEquipmentPage(),
            ),
            mockNavigatorObserver: mockNavigatorObserver,
          ),
        );
      },
    );
  });
}
