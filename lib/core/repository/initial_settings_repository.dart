import 'package:dio/dio.dart';

import '../constants.dart';
import '../entity/model/locale_model.dart';
import '../exception/gm_server_exception.dart';
import 'client/client.dart';

class InitialSettingsRepository {
  InitialSettingsRepository(this.client);

  final Dio client;

  Future<List<LocaleModel>> fetchAllLocales(String serverName) async {
    try {
      final response = await client.get(
        'https://$serverName.greenmile.com/$I18N_LOCALE',
        queryParameters: {
          CONSUMER: consumer,
        },
      );
      final responseList = response.data as List;
      return List.generate(
          responseList.length, (i) => LocaleModel.fromJson(responseList[i]));
    } on Exception {
      throw GMServerException('loader.server.version');
    }
  }

  Future<bool> authIdpDiscovery(String serverName) async {
    try {
      final response = await client.get(
        'https://$serverName.greenmile.com/$AUTH/$IDP/$DISCOVERY',
        queryParameters: {
          CONSUMER: moduleName,
          SCOPE: moduleScope,
        },
      );
      return response.isOk;
    } on Exception {
      return false;
    }
  }
}
