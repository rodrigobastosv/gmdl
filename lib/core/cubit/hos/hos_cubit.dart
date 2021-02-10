import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../exception/exceptions.dart';
import '../../global/global_info.dart';
import '../../repository/repositories.dart';
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

  int lunchTimeInMinutes = 0;
  StreamSubscription lunchTimeSubscription;

  Future<void> startLunch(String eventTime) async {
    try {
      _repository.startLunch(
        driverId: driverId,
        eventTime: eventTime,
      );
      emit(LunchStarted());
      lunchTimeSubscription = Stream.periodic(ONE_MINUTE).listen((_) {
        lunchTimeInMinutes++;
        emit(LunchTimeMinutePassed(lunchTimeInMinutes));
      });
    } on HosEventException catch (e) {
      emit(LunchStartFailed(e.errorMessage));
    }
  }

  Future<void> endLunch(String eventTime) async {
    try {
      _repository.endLunch(
        driverId: driverId,
        eventTime: eventTime,
      );
      emit(LunchEnded());
    } on HosEventException catch (e) {
      emit(LunchEndFailed(e.errorMessage));
    }
  }

  @override
  Future<void> close() {
    lunchTimeSubscription?.cancel();
    return super.close();
  }
}
