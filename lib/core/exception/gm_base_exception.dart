abstract class GMBaseException implements Exception {
  GMBaseException(this.errorMessage);

  final String errorMessage;
}
