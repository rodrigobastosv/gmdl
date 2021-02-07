import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../route/route_cubit.dart';
import '../../entity/model/models.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit({
    @required RouteCubit routeCubit,
  })  : assert(routeCubit != null),
        _routeCubit = routeCubit,
        super(MapInitial());

  final RouteCubit _routeCubit;
  StreamSubscription<RouteState> routeStateSubscription;

  RouteCubit get routeCubit => _routeCubit;

  void init() {
    routeStateSubscription = _routeCubit.listen((state) {
      if (state is DriverPositionUpdated) {
        emit(UpdateDriverPosition(state.position));
      } else if (state is ArrivedStopSuccess) {
        emit(ShowedStopOnMap(null));
      }
    });
  }

  void showStopOnMap(StopModel stop) {
    emit(ShowedStopOnMap(stop));
  }

  @override
  Future<void> close() {
    routeStateSubscription?.cancel();
    return super.close();
  }
}
