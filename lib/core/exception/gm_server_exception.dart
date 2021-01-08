import 'exceptions.dart';

class GMServerException implements GMBaseException {
  GMServerException(this.statusCode, this.message);

  final int statusCode;
  final String message;
}
