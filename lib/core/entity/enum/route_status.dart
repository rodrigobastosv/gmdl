enum RouteStatus {
  NOT_STARTED,
  STARTED,
  DEPARTED_ORIGIN,
  COMPLETED,
}

String statusToJson(RouteStatus status) {
  switch (status) {
    case RouteStatus.NOT_STARTED:
      return 'NOT_STARTED';
    case RouteStatus.STARTED:
      return 'STARTED';
    case RouteStatus.DEPARTED_ORIGIN:
      return 'DEPARTED_ORIGIN';
    case RouteStatus.COMPLETED:
      return 'COMPLETED';
  }
  return null;
}

RouteStatus statusFromJson(String status) {
  switch (status) {
    case 'NOT_STARTED':
      return RouteStatus.NOT_STARTED;
    case 'STARTED':
      return RouteStatus.STARTED;
    case 'DEPARTED_ORIGIN':
      return RouteStatus.DEPARTED_ORIGIN;
    case 'COMPLETED':
      return RouteStatus.COMPLETED;
  }
  return RouteStatus.NOT_STARTED;
}
