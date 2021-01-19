enum UndeliverableCodeType {
  BACK_LATTER,
  UNSUCCESSFULL,
  BOTH,
}

String undeliverableCodeTypeToJson(UndeliverableCodeType type) {
  switch (type) {
    case UndeliverableCodeType.BACK_LATTER:
      return 'L';
    case UndeliverableCodeType.UNSUCCESSFULL:
      return 'U';
    case UndeliverableCodeType.BOTH:
      return 'B';
  }
  return 'B';
}

UndeliverableCodeType undeliverableCodeTypeFromJson(String status) {
  switch (status) {
    case 'L':
      return UndeliverableCodeType.BACK_LATTER;
    case 'U':
      return UndeliverableCodeType.UNSUCCESSFULL;
    case 'B':
      return UndeliverableCodeType.BOTH;
  }
  return UndeliverableCodeType.BOTH;
}
