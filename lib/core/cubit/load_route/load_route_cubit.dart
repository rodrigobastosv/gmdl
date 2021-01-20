import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entity/dto/route_view_info_dto.dart';
import '../../entity/model/models.dart';
import '../../repository/repositories.dart';
import '../../store/store.dart';

part 'load_route_state.dart';

class LoadRouteCubit extends Cubit<LoadRouteState> {
  LoadRouteCubit({
    @required RouteRepository repository,
    @required this.store,
  })  : assert(repository != null),
        assert(store != null),
        _repository = repository,
        super(RouteAtGlanceInitial());

  final RouteRepository _repository;
  final Store store;

  RouteViewInfoDTO routeViewInfo;
  RouteModel route;

  Future<void> fetchRouteInformation() async {
    emit(const LoadingInfo('Loading Basic Route Informations'));
    final driverInfo = store.driverInfo;
    final username = driverInfo.login;
    try {
      routeViewInfo = await _repository.fetchRouteView(username);
      emit(const LoadingInfo('Loading Route'));

      final dataLoad = await _repository.fetchRoute(routeViewInfo.route.id);
      final featureStates =
          FeatureStateModel.fromJsonList(dataLoad['featureStates']);
      store.featureStates = featureStates;
      route = RouteModel.fromJson(dataLoad['route']);

      emit(RouteLoadedSuccess(route));
    } on Exception {
      emit(RouteLoadFailed());
    }
  }
}
