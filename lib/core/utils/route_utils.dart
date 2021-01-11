import '../entity/model/models.dart';

bool isPendingStop(StopModel stop) =>
    stop.actualDeparture == null && !stop.canceled;

bool isDoneStop(StopModel stop) => !isPendingStop(stop);
