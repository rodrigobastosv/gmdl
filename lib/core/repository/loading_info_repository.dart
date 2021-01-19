import 'package:dio/dio.dart';

import '../entity/dto/dtos.dart';
import '../entity/dto/mobile_device_dto.dart';
import '../entity/model/models.dart';
import '../exception/exceptions.dart';
import 'client/client.dart';
import 'filters/filters.dart';

class LoadingInfoRepository {
  LoadingInfoRepository(this._client);

  final Dio _client;

  Future<DriverInfoDto> getDriverInfo({
    String username,
  }) async {
    try {
      final response = await _client.post(
        '/$DRIVER/$RESTRICTIONS',
        queryParameters: {
          CRITERIA: {
            FILTERS: driverFilters,
            FIRST_RESULT: 0,
            MAX_RESULTS: 51,
          },
        },
        data: {
          CRITERIA_CHAIN: [
            {
              AND: [
                {ATTR: 'login', EQUAL: username}
              ]
            },
          ],
        },
      );
      final driverInfoList = handleResponse(response) as List;
      if (driverInfoList.isNotEmpty) {
        return DriverInfoDto.fromJson(driverInfoList[0]);
      }
      return null;
    } on Exception {
      rethrow;
    }
  }

  Future<MobileDeviceDto> registerDevice({
    String deviceModel,
    String platform,
    String platformVersion,
    int registrationAccuracy,
    String registrationGPSProvider,
    String registrationIp,
    double registrationLatitude,
    double registrationLongitude,
    String uniqueDeviceId,
  }) async {
    try {
      final response = await _client.post(
        '/$MOBILE_DEVICE/$REGISTER',
        data: {
          'deviceModel': deviceModel,
          'platform': platform,
          'platformVersion': platformVersion,
          'registrationAccuracy': registrationAccuracy,
          'registrationGPSProvider': registrationGPSProvider,
          'registrationIp': registrationIp,
          'registrationLatitude': registrationLatitude,
          'registrationLongitude': registrationLongitude,
          'uniqueDeviceId': uniqueDeviceId,
        },
      );
      final responseData = handleResponse(response) as Map<String, dynamic>;
      return MobileDeviceDto.fromJson(responseData['mobileDevice']);
    } on DioError catch (e) {
      throw SignInException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw SignInException(e.errorMessage);
    }
  }

  Future<void> bindModule({
    int deviceId,
    String appVersion,
    String moduleKey,
  }) async {
    try {
      _client.post('/$MOBILE_DEVICE/$deviceId/$BIND_MODULE', queryParameters: {
        'returnEntity': true,
      }, data: {
        'appVersion': appVersion,
        'module': {
          'key': moduleKey,
        }
      });
    } on DioError {} on GMServerException {}
  }

  Future<void> fetchAppVersion({
    int deviceId,
  }) async {
    try {
      _client.get('/$MOBILE_VERSION/$DEVICE/$deviceId');
    } on DioError {} on GMServerException {}
  }

  Future<void> logDevice({
    int deviceId,
    int userId,
  }) async {
    try {
      _client.post(
        '/$MOBILE_DEVICE/$deviceId/$LOG',
        data: {
          'accuracy': 2765,
          'batteryLevel': null,
          'device': {
            'id': deviceId,
          },
          'fromIP': "10.1.1.1",
          'gpsProvider': "PASSIVE",
          'latitude': -3.7617664,
          'longitude': -38.479462399999996,
          'phoneNumber': null,
          'simSerialNumber': null,
          'user': {
            'id': userId,
          },
        },
      );
    } on DioError catch (e) {
      throw SignInException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw SignInException(e.errorMessage);
    }
  }

  Future<GlobalConfigurationsDto> getGlobalConfigurations() async {
    try {
      final response = await _client.post(
        '/$GLOBAL_CONFIGURATION/$RESTRICTIONS',
        queryParameters: {
          CRITERIA: {
            FILTERS: globalConfigurationFilters,
          },
        },
      );
      final globalConfigs = handleResponse(response) as List;
      return GlobalConfigurationsDto.fromJson(globalConfigs[0]);
    } on Exception {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserConfigurations() async {
    try {
      final response = await _client.get(
        '/$CONFIGURATION/loggedUser',
      );
      return handleResponse(response);
    } on Exception {
      rethrow;
    }
  }

  Future<List<CancelCodeModel>> fetchCancelCodes() async {
    try {
      final response = await _client.post('/$CANCEL_CODE/$FILTER', data: {
        'enabled': true,
      });
      final responseData = handleResponse(response) as List;
      return List.generate(responseData.length,
          (i) => CancelCodeModel.fromJson(responseData[i]));
    } on Exception {
      rethrow;
    }
  }

  Future<List<UndeliverableCodeModel>> fetchUndeliverableCodes() async {
    try {
      final response =
          await _client.post('/$UNDELIVERABLE_CODE/$FILTER', data: {
        'enabled': true,
      });
      final responseData = handleResponse(response) as List;
      return List.generate(responseData.length,
          (i) => UndeliverableCodeModel.fromJson(responseData[i]));
    } on Exception {
      rethrow;
    }
  }
}
