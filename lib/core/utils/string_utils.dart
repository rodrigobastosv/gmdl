import 'dart:math';

String generateRandomString(int len) {
  var random = Random.secure();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[random.nextInt(_chars.length)])
      .join();
}

String getOnlyTenantFromUrl(String url) {
  return url
      .replaceFirst('http://', '')
      .replaceFirst('https://', '')
      .replaceFirst('.greenmile.com', '')
      .replaceFirst('/', '');
}
