import 'package:url_launcher/url_launcher.dart';

import '../exception/exceptions.dart';

class LaunchService {
  Future<void> launchMap({
    double latitude,
    double longitude,
  }) async {
    final mapUri = Uri.parse(
        '''geo:$latitude,$longitude?q=$latitude,$longitude($latitude,$longitude)''');
    final mapUriString = mapUri.toString();
    try {
      if (await canLaunch(mapUriString)) {
        await launch(mapUriString);
      }
    } on Exception {
      throw LaunchActionException('Error while trying to open map');
    }
  }
}
