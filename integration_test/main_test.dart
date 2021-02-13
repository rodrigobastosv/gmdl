import 'package:flutter_test/flutter_test.dart';
import 'package:gm_driver_lite/page/pages.dart';
import 'package:integration_test/integration_test.dart';

import 'package:gm_driver_lite/main.dart' as app;

import 'data/auth.dart';
import 'data/organization_data.dart';
import 'data/utils.dart';

const TEST_SERVER = 'validator21-test';

String token;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  int organizationId;

  setUpAll(() async {
    token = await authAdmin();
    organizationId = await loadFixtureData();
  });

  tearDownAll(() async {
    await deleteOrganization(organizationId);
  });

  testWidgets(
    '''WHEN app launches
       SHOULD show the InitialSettingsPage
    ''',
    (tester) async {
      await app.main();
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(minutes: 5));
      expect(find.byType(InitialSettingsPage), findsOneWidget);
    },
  );
}
