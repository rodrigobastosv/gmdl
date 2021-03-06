import 'package:gm_driver_lite/core/extension/extensions.dart';

final basicRoute = {
  'route': {
    'key': 'route-GMD_849-cy',
    'hasHelper': false,
    'description': 'Route Cypress test for GMD_849 execution',
    'organization': {
      'key': 'org-GMD_849-cy',
    },
    'origin': {
      'key': 'origin-GMD_849-cy',
      'locationType': {
        'key': 'LocationTypeGMD_849',
        'description': 'GMD_849 LocationType',
        'enabled': true
      },
      'longitude': -38.46933,
      'latitude': -3.734536
    },
    'lastStopIsDestination': false,
    'destination': {
      'key': 'destination-GMD_849-cy',
      'locationType': {
        'key': 'LocationTypeGMD_849',
        'description': 'GMD_849 LocationType',
        'enabled': true
      },
      'longitude': -38.46933,
      'latitude': -3.734536
    },
    'driverAssignments': [
      {
        'driver': {
          'key': 'driver-GMD_849-cy',
          'login': 'driver-GMD_849-cy',
          'name': 'driver-GMD_849-cy',
          'password': '123',
          'enabled': true,
          'preferedLocale': {'key': 'I18NLocale_en'},
          'unitSystem': 'METRIC',
          'driverType': 'DEFAULT',
          'smartTrack': false
        },
        'principal': 'true'
      }
    ],
    'principalEquipment': 'equipment-GMD_849-cy',
    'equipmentAssignments': [
      {
        'equipment': {
          'key': 'equipment-GMD_849-cy',
          'enabled': true,
          'description': 'equipment-GMD_849-cy',
          'equipmentType': {
            'key': 'EquipmentTypeGMD_849',
            'description': 'GMD_849 EquipmentType',
            'vehicleType': 'TRUCK',
            'enabled': true
          }
        },
        'principal': true
      }
    ],
    'stops': [
      {
        'key': 's1-GMD_849-cy',
        'plannedArrival': DateTime.now().toUtcAsString,
        'plannedDeparture': DateTime.now().toUtcAsString,
        'stopType': {
          'key': 'StopTypeGMD_849',
          'description': 'GMD_849 StopType',
          'type': 'STOP',
          'locationRequired': false
        },
        'location': {
          'key': 'GMD_849-Loc1',
          'locationType': {
            'key': 'LocationTypeGMD_849',
            'description': 'GMD_849 LocationType',
            'enabled': true
          },
          'longitude': -38.46933,
          'latitude': -3.734536
        }
      }
    ]
  },
  'undeliverableCodes': [
    {
      'key': 'undeliverable-GMD_849-1',
      'description': 'redelivery 1',
      'type': 'B'
    }
  ],
  'organization': {
    'key': 'org-GMD_849-cy',
    'unitSystem': 'METRIC',
    'description': 'org-GMD_849-cy',
    'timeZone': {
      'timezoneName': 'America/Sao_Paulo',
    }
  },
  'sizeAliases': [
    {
      'key': 'CJ-GMD_849',
      'icon': 'gmfont-sizes-icon-box',
      'description': 'GMD_849 CJ',
      'preferredSize': '1'
    },
    {
      'key': 'BOT-GMD_849',
      'icon': 'gmfont-sizes-icon-bottles',
      'description': 'GMD_849 BOT',
      'preferredSize': '2'
    },
    {
      'key': 'PZA-GMD_849',
      'icon': 'gmfont-sizes-icon-keg',
      'description': 'GMD_849 PZA',
      'preferredSize': '3'
    }
  ]
};
