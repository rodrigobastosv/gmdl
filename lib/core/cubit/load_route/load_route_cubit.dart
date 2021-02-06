import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entity/dto/route_view_info_dto.dart';
import '../../entity/model/models.dart';
import '../../exception/exceptions.dart';
import '../../global/global_info.dart';
import '../../repository/repositories.dart';
import '../cubits.dart';

part 'load_route_state.dart';

class LoadRouteCubit extends Cubit<LoadRouteState> {
  LoadRouteCubit({
    @required RouteRepository repository,
    @required this.globalInfo,
    @required I18nCubit i18nCubit,
  })  : assert(repository != null),
        assert(globalInfo != null),
        assert(i18nCubit != null),
        _repository = repository,
        _i18nCubit = i18nCubit,
        super(RouteAtGlanceInitial());

  final RouteRepository _repository;
  final GlobalInfo globalInfo;
  final I18nCubit _i18nCubit;

  RouteViewInfoDTO routeViewInfo;
  RouteModel route;

  Future<void> fetchRouteInformation() async {
    emit(LoadingInfo(_i18nCubit.getFormattedText('loading.downloading.route')));
    final driverInfo = globalInfo.driverInfo;
    final username = driverInfo.login;
    try {
      routeViewInfo = await _repository.fetchRouteView(username);

      final dataLoad = await _repository.fetchRoute(routeViewInfo.route.id);
      final featureStates =
          FeatureStateModel.fromJsonList(dataLoad['featureStates']);
      globalInfo.featureStates = featureStates;
      route = RouteModel.fromJson(dataLoad['route']);

      final routePath =
          await _repository.fetchRoutePath(route.id);
      route = route.copyWith(
        routePath: routePath,
      );

      emit(RouteLoadedSuccess(route));
    } on NoneRouteFoundException catch (e) {
      emit(RouteLoadFailed(e.errorMessage));
    } on FetchRouteException catch (e) {
      emit(RouteLoadFailed(e.errorMessage));
    }
  }
}
