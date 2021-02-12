import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../entity/enum/enums.dart';
import '../../repository/gps_repository.dart';
import '../../service/gps_service.dart';

part 'gps_state.dart';

class GpsCubit extends Cubit<GpsState> {
  GpsCubit({
    GpsRepository repository,
    GpsService gpsService,
  })  : assert(repository != null),
        assert(gpsService != null),
        _repository = repository,
        _gpsService = gpsService,
        super(GpsInitial());

  final GpsRepository _repository;
  final GpsService _gpsService;

  Position lastPosition;
  StreamSubscription<Position> _positionsSubscription;

  void initPositionTracking() {
    _positionsSubscription = _gpsService.getLocationStream().listen((position) {
      lastPosition = position;
      emit(GpsNewPosition(lastPosition));
    });
    emit(GpsDriverPositionTrackingStartSuccess());
  }

  Future<void> sendStopGpsInfo(
    StopEvent stopEvent, {
    @required int routeId,
    @required String stopKey,
  }) async {
    final currentPosition = await _gpsService.getCurrentPosition();
    if (stopEvent == StopEvent.ARRIVE_STOP) {
      _repository.sendStopArrivalGpsInfo(
        routeId: routeId,
        stopKey: stopKey,
        accuracyMeters: currentPosition.accuracy,
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude,
      );
    } else if (stopEvent == StopEvent.DEPART_STOP) {
      _repository.sendStopDepartureGpsInfo(
        routeId: routeId,
        stopKey: stopKey,
        accuracyMeters: currentPosition.accuracy,
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude,
      );
    } else if (stopEvent == StopEvent.CANCEL_STOP) {
      _repository.sendStopCancelGpsInfo(
        routeId: routeId,
        stopKey: stopKey,
        accuracyMeters: currentPosition.accuracy,
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude,
      );
    }
  }

  @override
  Future<void> close() {
    _positionsSubscription?.cancel();
    return super.close();
  }
}
