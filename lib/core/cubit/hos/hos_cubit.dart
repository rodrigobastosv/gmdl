import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entity/model/models.dart';
import '../../exception/exceptions.dart';
import '../../global/global_info.dart';
import '../../repository/repositories.dart';
import '../../utils/hos_utils.dart';
import '../../utils/utils.dart';

part 'hos_state.dart';

class HosCubit extends Cubit<HosState> {
  HosCubit({
    @required HosRepository repository,
    @required GlobalInfo globalInfo,
  })  : assert(repository != null),
        assert(globalInfo != null),
        _repository = repository,
        _globalInfo = globalInfo,
        super(HosInitial());

  final HosRepository _repository;
  final GlobalInfo _globalInfo;

  int get driverId => _globalInfo.driverInfo.id;
  bool get allowLunchAppointment => hosType?.allowLunchAppointment ?? false;

  HosTypeModel hosType;
  List<HosEventModel> hosEvents;
  int lunchTimeInMinutes = 0;
  StreamSubscription lunchTimeSubscription;

  Future<void> startLunch(String eventTime) async {
    try {
      _repository.startLunch(
        driverId: driverId,
        eventTime: eventTime,
      );
      emit(HosLunchStartSuccess());
      lunchTimeSubscription = Stream.periodic(ONE_MINUTE).listen((_) {
        lunchTimeInMinutes++;
        emit(HosLunchTimeMinutePass(lunchTimeInMinutes));
      });
    } on HosEventException catch (e) {
      emit(HosLunchStartFailure(e.errorMessage));
    }
  }

  Future<void> endLunch(String eventTime) async {
    try {
      _repository.endLunch(
        driverId: driverId,
        eventTime: eventTime,
      );
      lunchTimeInMinutes = 0;
      lunchTimeSubscription.cancel();
      emit(HosLunchEndSuccess());
    } on HosEventException catch (e) {
      emit(HosLunchEndFailure(e.errorMessage));
    }
  }

  Future<void> fetchHosInfo({
    int driverId,
  }) async {
    final hosInfo = await _repository.fetchHosInfo(
      driverId: _globalInfo.driverInfo.id,
    );
    hosType = hosInfo['hosType'];
    hosEvents = hosInfo['hosEvents'];
    final lunchStartEvent = getLunchStartEvent(hosEvents);
    if (lunchStartEvent != null) {
      _restartLunchTimer(lunchStartEvent.eventTime);
    }
  }

  Future<void> _restartLunchTimer(String eventTime) async {
    final now = DateTime.now();
    final startTime = DateTime.parse(eventTime);
    final difference = now.difference(startTime);
    lunchTimeInMinutes = difference.inMinutes;
    emit(HosRestartLunchTimer());
    lunchTimeSubscription = Stream.periodic(ONE_MINUTE).listen((_) {
      lunchTimeInMinutes++;
      emit(HosLunchTimeMinutePass(lunchTimeInMinutes));
    });
  }

  @override
  Future<void> close() {
    lunchTimeSubscription?.cancel();
    return super.close();
  }
}
