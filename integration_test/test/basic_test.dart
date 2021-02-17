import 'package:flutter_test/flutter_test.dart';
import 'package:gm_driver_lite/core/keys.dart';
import 'package:gm_driver_lite/page/pages.dart';
import 'package:integration_test/integration_test.dart';

import 'package:gm_driver_lite/main.dart' as app;

import '../data/auth.dart';
import '../data/organization_data.dart';
import '../data/utils.dart';
import '../utils.dart';

const TEST_SERVER = 'validator21-test';

String token;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  int organizationId;

  setUpAll(() async {
    print('Auth user!');
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
      final initialSettingsPage = find.byType(InitialSettingsPage);
      expect(initialSettingsPage, findsOneWidget);
    },
  );

  testWidgets(
    '''WHEN app launches
       AND a valid server is choosed
       SHOULD navigate to Sign in page
    ''',
    (tester) async {
      await app.main();
      await tester.pumpAndSettle();
      final serverFormField = find.byKey(initialSettingsServerKey);
      await tester.enterText(serverFormField, 'validator21-test');
      await tester.pumpAndSettle();
      final fab = find.byKey(initialSettingsFabKey);
      expect(fab, findsOneWidget);
      await tester.tap(fab);
      await tester.pumpAndSettle(DEFAULT_DELAY);
      final signInPage = find.byType(SignInPage);
      expect(signInPage, findsOneWidget);
    },
  );
}
