import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../entity/dto/route_view_info_dto.dart';
import '../../entity/model/models.dart';
import '../../hive/boxes.dart';
import '../../repository/repositories.dart';

part 'load_route_state.dart';

class LoadRouteCubit extends Cubit<LoadRouteState> {
  LoadRouteCubit({
    @required RouteRepository repository,
    @required Box driverBox,
  })  : _repository = repository,
        _driverBox = driverBox,
        super(RouteAtGlanceInitial());

  final RouteRepository _repository;
  final Box _driverBox;

  RouteViewInfoDTO routeViewInfo;
  RouteModel route;

  Future<void> fetchRouteView() async {
    emit(const LoadingInfo('Loading Basic Route Informations'));
    final driverInfo = _driverBox.get(DRIVER_INFO);
    final username = driverInfo['login'];
    try {
      routeViewInfo = await _repository.fetchRouteView(username);
      emit(const LoadingInfo('Loading Route'));

      try {
        route = await _repository.fetchRoute(routeViewInfo.id);
        emit(RouteLoadedSuccess(route));
      } on Exception {
        emit(RouteLoadFailed());
      }
    } on Exception {
      emit(RouteLoadFailed());
    }
  }
}
