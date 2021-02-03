import 'exceptions.dart';

class RedeliverStopException extends GMBaseException {
  RedeliverStopException(String errorMessage) : super(errorMessage);
}
