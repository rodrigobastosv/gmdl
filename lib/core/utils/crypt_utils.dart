import 'dart:convert';

String encodeString(String valueToEncode) =>
      base64.encode(utf8.encode(valueToEncode));

  String decodeString(String valueToDecode) =>
      utf8.decode(base64.decode(valueToDecode));