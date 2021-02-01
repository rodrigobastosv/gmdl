import 'package:connectivity/connectivity.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

import 'package:gm_driver_lite/core/repository/repositories.dart';

// Repository
class MockEquipmentRepository extends Mock implements EquipmentRepository {}

class MockI18nRepository extends Mock implements I18nRepository {}

class MockInitialSettingsRepository extends Mock
    implements InitialSettingsRepository {}

// General
class MockConnectivity extends Mock implements Connectivity {}

class MockBox extends Mock implements Box {}
