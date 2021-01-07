import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../entity/dto/route_view_info_dto.dart';
import '../../entity/model/models.dart';
import '../../hive/boxes.dart';
import '../../repository/repositories.dart';

part 'route_at_glance_state.dart';

class RouteAtGlanceCubit extends Cubit<RouteAtGlanceState> {
  RouteAtGlanceCubit({
    @required this.repository,
    @required this.driverBox,
  }) : super(RouteAtGlanceInitial());

  final RouteRepository repository;
  final Box driverBox;

  RouteViewInfoDTO routeViewInfo;
  RouteModel route;

  Future<void> fetchRouteView() async {
    emit(const LoadingInfo('Loading Basic Route Informations'));
    final driverInfo = driverBox.get(DRIVER_INFO);
    final username = driverInfo['login'];
    try {
      routeViewInfo = await repository.fetchRouteView(username);
      emit(const LoadingInfo('Loading Route'));

      try {
        route = await repository.fetchRoute(routeViewInfo.id);
        emit(RouteLoadedSuccess(route));
      } on Exception {
        emit(RouteLoadFailed());
      }
    } on Exception {
      emit(RouteAtGlanceLoadingFailed());
    }
  }
}
