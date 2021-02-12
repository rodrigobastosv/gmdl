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

const SERVER = 'textfile';
String token;
int organizationId;
int equipmentTypeId;
int equipmentId;
int driverId;
int sizeAlias1Id;
int sizeAlias2Id;
int sizeAlias3Id;
int skuTypeId;
int hosTypeId;
int skuId;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    token = await authAdmin();
    organizationId = await createOrganization();
    equipmentTypeId = await createEquipmentType();
    equipmentId = await createEquipment();
    driverId = await createDriver();
    sizeAlias1Id = await createSizeAlias('1');
    sizeAlias2Id = await createSizeAlias('2');
    sizeAlias3Id = await createSizeAlias('3');
    skuTypeId = await createSkuType();
    hosTypeId = await createHosType();
    skuId = await createSku();
  });

  tearDownAll(() async {
    await deleteOrganization();
    await deleteEquipmentType();
    await deleteEquipment();
    await deleteDriver();
    await deleteSizeAlias(sizeAlias1Id);
    await deleteSizeAlias(sizeAlias2Id);
    await deleteSizeAlias(sizeAlias3Id);
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
