import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gm_driver_lite/core/repository/driver_info_repository.dart';

part 'driver_info_state.dart';

class DriverInfoCubit extends Cubit<DriverInfoState> {
  DriverInfoCubit(
    this.repository,
  ) : super(DriverInfoInitial());

  final DriverInfoRepository repository;

  Future<void> getDriverInfo(String username) async {
    emit(DriverInfoLoading());
    try {
      final driverInfo = await repository.getDriverInfo(
        username: username,
      );
      print(driverInfo);
      emit(DriverInfoSuccess());
    } on Exception {
      emit(DriverInfoFailed());
    }
  }
}
