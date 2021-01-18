import 'exceptions.dart';

class UndeliverableStopException extends GMBaseException {
  UndeliverableStopException(String errorMessage) : super(errorMessage);
}
