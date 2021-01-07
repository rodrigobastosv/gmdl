import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entity/model/models.dart';
import '../../repository/repositories.dart';

part 'route_state.dart';

class RouteCubit extends Cubit<RouteState> {
  RouteCubit({
    @required this.route,
    @required this.repository,
  }) : super(RouteInitial());

  final RouteModel route;
  final RouteRepository repository;
}
