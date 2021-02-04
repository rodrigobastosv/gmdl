import 'package:flutter_test/flutter_test.dart';
import 'package:gm_driver_lite/page/pages.dart';
import 'package:integration_test/integration_test.dart';

import 'package:gm_driver_lite/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    '''WHEN app launches
       SHOULD show the InitialSettingsPage
    ''',
    (tester) async {
      await app.main();
      await tester.pumpAndSettle();
      expect(find.byType(InitialSettingsPage), findsOneWidget);
    },
  );
}
