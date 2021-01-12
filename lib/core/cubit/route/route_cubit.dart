import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../entity/model/models.dart';
import '../../hive/boxes.dart';
import '../../repository/repositories.dart';
import '../../selector/route_selectors.dart';

part 'route_state.dart';

class RouteCubit extends Cubit<RouteState> {
  RouteCubit({
    @required this.route,
    @required RouteRepository repository,
    @required this.driverBox,
  })  : _repository = repository,
        super(RouteInitial());

  RouteModel route;
  final RouteRepository _repository;
  final Box driverBox;

  String get driverName => driverBox.get(DRIVER_INFO)['name'];

  Future<void> startRoute() async {
    try {
      emit(StartingRoute());
      final routeStarted = await _repository.startRoute(route.id);
      if (routeStarted) {
        emit(RouteStartedSuccess());
      } else {
        emit(RouteStartFailed());
      }
    } on Exception {
      emit(RouteStartFailed());
    }
  }

  Future<void> departOrigin() async {
    try {
      emit(DepartingOrigin());
      final departedOrigin = await _repository.departOrigin(route.id);
      if (departedOrigin) {
        emit(DepartOriginSuccess());
      } else {
        emit(DepartOriginFailed());
      }
    } on Exception {
      emit(DepartOriginFailed());
    }
  }

  Future<void> arriveStop(StopModel stop) async {
    try {
      emit(ArrivingStop());
      final arrivedStop = await _repository.arriveStop(route.id, stop);
      if (arrivedStop) {
        emit(ArrivedStopSuccess(stop));
      } else {
        emit(ArrivedStopFailed());
      }
    } on Exception {
      emit(ArrivedStopFailed());
    }
  }

  void updateRouteDueToDepartStop(StopModel stop) {
    final stops = route.stops;
    final stopIndex = stops.indexWhere((it) => stop.id == it.id);
    stops[stopIndex] = stop;
    route = route.copyWith(
      stops: stops,
    );
    if (hasPendingStops(route)) {
      emit(RouteUpdatedDueDepartStop(stop));
    } else {
      emit(RouteHasNoPendingStops());
    }
  }

  Future<void> arriveWarehouse() async {
    try {
      emit(ArrivingWarehouse());
      final arrivedWarehouse = await _repository.arriveWarehouse(route.id);
      if (arrivedWarehouse) {
        emit(ArrivedWarehouseSuccess());
      } else {
        emit(ArrivedWarehouseFailed());
      }
    } on Exception {
      emit(ArrivedWarehouseFailed());
    }
  }

  Future<void> completeRoute() async {
    try {
      emit(CompletingRoute());
      final routeCompleted = await _repository.completeRoute(route.id);
      if (routeCompleted) {
        emit(RouteCompletedSuccess());
      } else {
        emit(RouteCompletedFailed());
      }
    } on Exception {
      emit(RouteCompletedFailed());
    }
  }
}
