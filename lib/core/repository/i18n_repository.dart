import '../entity/model/models.dart';
import '../i18n/i18n_required.dart';
import 'client/client.dart';
import 'client/gm_client.dart';
import 'filters/filters.dart';

class I18nRepository {
  I18nRepository(this._client);

  final GMClient _client;

  Future<List<ResourceModel>> fetchResources(String locale) async {
    try {
      final response = await _client.post(
        '/$I18N_RESOURCE/$RESTRICTIONS',
        queryParameters: {
          CRITERIA: getCriteria({
            FILTERS: resourceFilters,
          }),
        },
        data: {
          CRITERIA_CHAIN: [
            {
              AND: [
                {
                  ATTR: 'key',
                  IN: [...requiredKeys]
                },
                {
                  ATTR: 'module.key',
                  IN: [
                    'GreenMileDriver',
                    'GreenMileDriverGeneric',
                    'GreenMileLoader'
                  ]
                },
                {ATTR: 'i18nlocale.language', EQUAL: locale},
              ]
            },
          ],
        },
      );
      final responseData = handleResponse(response) as List;
      return List.generate(
          responseData.length, (i) => ResourceModel.fromJson(responseData[i]));
    } on Exception {
      rethrow;
    }
  }
}
