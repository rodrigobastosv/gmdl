import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gm_driver_lite/core/repository/driver_info_repository.dart';

part 'driver_info_state.dart';

class DriverInfoCubit extends Cubit<DriverInfoState> {
  DriverInfoCubit({
    this.username,
    this.repository,
  }) : super(DriverInfoInitial());

  final String username;
  final DriverInfoRepository repository;
}
