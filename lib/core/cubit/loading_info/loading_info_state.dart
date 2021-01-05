part of 'loading_info_cubit.dart';

abstract class LoadingInfoState extends Equatable {
  const LoadingInfoState();

  @override
  List<Object> get props => [];
}

class LoadingInitial extends LoadingInfoState {}

class BasicDriverInfoSuccess extends LoadingInfoState {}

class AllInfoLoadedSuccess extends LoadingInfoState {}

class FetchGlobalConfigSuccess extends LoadingInfoState {}

class DriverInfoFailed extends LoadingInfoState {}

class InfoLoading extends LoadingInfoState {
  InfoLoading(this.step);

  final String step;

  @override
  List<Object> get props => [step];
}
