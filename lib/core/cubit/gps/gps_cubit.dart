import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../service/gps_service.dart';

part 'gps_state.dart';

class GpsCubit extends Cubit<GpsState> {
  GpsCubit(this._gpsService) : super(GpsInitial());

  final GpsService _gpsService;
  StreamSubscription<Position> _positionsSubscription;

  void initPositionTracking() {
    _positionsSubscription = _gpsService.getLocationStream().listen((position) {
      emit(NewPosition(position));
    });
    emit(DriverPositionTrackingStarted());
  }

  @override
  Future<void> close() {
    _positionsSubscription.cancel();
    return super.close();
  }
}
