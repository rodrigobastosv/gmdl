part of 'load_info_cubit.dart';

abstract class LoadInfoState extends Equatable {
  const LoadInfoState();

  @override
  List<Object> get props => [];
}

class LoadInfoInitial extends LoadInfoState {}

class LoadInfoBasicDriverInfo extends LoadInfoState {}

class LoadInfoRegisterDevice extends LoadInfoState {
  LoadInfoRegisterDevice(this.deviceId);

  final int deviceId;

  @override
  List<Object> get props => [
        deviceId,
      ];
}

class LoadInfoAllInfoLoadSuccess extends LoadInfoState {}

class LoadInfoFetchGlobalConfig extends LoadInfoState {}

class LoadInfoFetchResources extends LoadInfoState {}

class LoadInfoFetchUserConfig extends LoadInfoState {}

class LoadInfoFetchCancelCodes extends LoadInfoState {}

class LoadInfoFetchUndeliverableCodes extends LoadInfoState {}

class LoadInfoInfoLoadingFailure extends LoadInfoState {}

class LoadInfoInfoLoading extends LoadInfoState {
  LoadInfoInfoLoading(this.step);

  final String step;

  @override
  List<Object> get props => [step];
}
