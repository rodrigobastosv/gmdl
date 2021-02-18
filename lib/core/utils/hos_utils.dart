import '../entity/enum/enums.dart';
import '../entity/model/models.dart';

HosEventModel getLunchStartEvent(List<HosEventModel> hosEvents) {
  return hosEvents
      .firstWhere((hosEvent) => hosEvent.eventType == HosEventType.LUNCH_START);
}
