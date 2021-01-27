enum NotificationAction {
  ADD_STOP,
  REMOVE_STOP,
  UPDATE_STOP,
  ROUTE_PROJECTED_UPDATE,
  UPDATE,
  ROUTE_PLANNED_UPDATE,
  DEPART_STOP,
  CANCEL_STOP,
  RETURN_STOP,
  REDELIVERY_STOP,
  DEPART_ROUTE,
  ROUTE_RESEQUENCE_SIMULATED,
  CARGO_RECONCILIATION_CREATED
}

String notificationActionToJson(NotificationAction type) {
  switch (type) {
    case NotificationAction.ADD_STOP:
      return 'ADD_STOP';
    case NotificationAction.REMOVE_STOP:
      return 'REMOVE_STOP';
    case NotificationAction.UPDATE_STOP:
      return 'UPDATE_STOP';
    case NotificationAction.ROUTE_PROJECTED_UPDATE:
      return 'ROUTE_PROJECTED_UPDATE';
    case NotificationAction.UPDATE:
      return 'UPDATE';
    case NotificationAction.ROUTE_PLANNED_UPDATE:
      return 'ROUTE_PLANNED_UPDATE';
    case NotificationAction.DEPART_STOP:
      return 'DEPART_STOP';
    case NotificationAction.CANCEL_STOP:
      return 'CANCEL_STOP';
    case NotificationAction.RETURN_STOP:
      return 'RETURN_STOP';
    case NotificationAction.RETURN_STOP:
      return 'RETURN_STOP';
    case NotificationAction.REDELIVERY_STOP:
      return 'REDELIVERY_STOP';
    case NotificationAction.DEPART_ROUTE:
      return 'DEPART_ROUTE';
    case NotificationAction.ROUTE_RESEQUENCE_SIMULATED:
      return 'ROUTE_RESEQUENCE_SIMULATED';
    case NotificationAction.CARGO_RECONCILIATION_CREATED:
      return 'CARGO_RECONCILIATION_CREATED';
  }
  return null;
}

NotificationAction notificationActionFromJson(String type) {
  switch (type) {
    case 'ADD_STOP':
      return NotificationAction.ADD_STOP;
    case 'REMOVE_STOP':
      return NotificationAction.REMOVE_STOP;
    case 'UPDATE_STOP':
      return NotificationAction.UPDATE_STOP;
    case 'ROUTE_PROJECTED_UPDATE':
      return NotificationAction.ROUTE_PROJECTED_UPDATE;
    case 'UPDATE':
      return NotificationAction.UPDATE;
    case 'ROUTE_PLANNED_UPDATE':
      return NotificationAction.ROUTE_PLANNED_UPDATE;
    case 'DEPART_STOP':
      return NotificationAction.DEPART_STOP;
    case 'CANCEL_STOP':
      return NotificationAction.CANCEL_STOP;
    case 'RETURN_STOP':
      return NotificationAction.RETURN_STOP;
    case 'RETURN_STOP':
      return NotificationAction.RETURN_STOP;
    case 'REDELIVERY_STOP':
      return NotificationAction.REDELIVERY_STOP;
    case 'DEPART_ROUTE':
      return NotificationAction.DEPART_ROUTE;
    case 'ROUTE_RESEQUENCE_SIMULATED':
      return NotificationAction.ROUTE_RESEQUENCE_SIMULATED;
    case 'CARGO_RECONCILIATION_CREATED':
      return NotificationAction.CARGO_RECONCILIATION_CREATED;
  }
  return null;
}
