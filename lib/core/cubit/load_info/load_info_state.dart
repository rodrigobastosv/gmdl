part of 'load_info_cubit.dart';

abstract class LoadInfoState extends Equatable {
  const LoadInfoState();

  @override
  List<Object> get props => [];
}

class LoadingInitial extends LoadInfoState {}

class BasicDriverInfoSuccess extends LoadInfoState {}

class AllInfoLoadedSuccess extends LoadInfoState {}

class FetchGlobalConfigSuccess extends LoadInfoState {}

class FetchUserConfigSuccess extends LoadInfoState {}

class FetchCancelCodesSuccess extends LoadInfoState {}

class DriverInfoFailed extends LoadInfoState {}

class InfoLoading extends LoadInfoState {
  InfoLoading(this.step);

  final String step;

  @override
  List<Object> get props => [step];
}
