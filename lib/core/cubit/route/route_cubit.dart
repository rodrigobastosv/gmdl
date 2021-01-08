import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../entity/model/models.dart';
import '../../hive/boxes.dart';
import '../../repository/repositories.dart';

part 'route_state.dart';

class RouteCubit extends Cubit<RouteState> {
  RouteCubit({
    @required this.route,
    @required RouteRepository repository,
    @required this.driverBox,
  })  : _repository = repository,
        super(RouteInitial());

  final RouteModel route;
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
      print(departedOrigin);
      if (departedOrigin) {
        emit(DepartOriginSuccess());
      } else {
        emit(DepartOriginFailed());
      }
    } on Exception catch (e) {
      print(e);
      emit(DepartOriginFailed());
    }
  }
}
