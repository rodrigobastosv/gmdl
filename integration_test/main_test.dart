import 'package:flutter_test/flutter_test.dart';
import 'package:gm_driver_lite/page/pages.dart';
import 'package:integration_test/integration_test.dart';

import 'package:gm_driver_lite/main.dart' as app;

import 'data/auth.dart';
import 'data/driver_data.dart';
import 'data/equipment_data.dart';
import 'data/hos_data.dart';
import 'data/organization_data.dart';
import 'data/size_alias_data.dart';
import 'data/sku_data.dart';

const SERVER = 'validator21-test';

String token;
Map<String, dynamic> organization;
Map<String, dynamic> equipmentType;
Map<String, dynamic> equipment;
Map<String, dynamic> driver;
Map<String, dynamic> sizeAlias1;
Map<String, dynamic> sizeAlias2;
Map<String, dynamic> sizeAlias3;
Map<String, dynamic> skuType;
Map<String, dynamic> hosType;
Map<String, dynamic> sku;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    token = await authAdmin();
    organization = await createOrganization();
    equipmentType = await createEquipmentType();
    equipment = await createEquipment();
    driver = await createDriver();
    sizeAlias1 = await createSizeAlias();
    sizeAlias2 = await createSizeAlias();
    sizeAlias3 = await createSizeAlias();
    skuType = await createSkuType();
    hosType = await createHosType();
    sku = await createSku();
  });

  tearDownAll(() async {
    await deleteOrganization();
    await deleteEquipmentType();
    await deleteEquipment();
    await deleteDriver();
    await deleteSizeAlias(sizeAlias1);
    await deleteSizeAlias(sizeAlias2);
    await deleteSizeAlias(sizeAlias3);
    await deleteSkuType();
    await deleteHosType();
    await deleteSku();
  });

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
