enum HosEventType {
  LUNCH_START,
  LUNCH_END,
}

String hosEventTypeToJson(HosEventType type) {
  switch (type) {
    case HosEventType.LUNCH_START:
      return 'LUNCH_START';
    case HosEventType.LUNCH_END:
      return 'LUNCH_END';
  }
  return null;
}
