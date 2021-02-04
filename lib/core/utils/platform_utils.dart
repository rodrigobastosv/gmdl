import 'dart:io' show Platform;

String getPlatform() {
  if (Platform.isAndroid) {
    return 'ANDROID';
  } else {
    return 'IOS';
  }
}

bool isAndroid() => Platform.isAndroid;

bool isIOS() => Platform.isIOS;
