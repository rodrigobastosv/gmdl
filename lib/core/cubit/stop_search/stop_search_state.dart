part of 'stop_search_cubit.dart';

abstract class StopSearchState extends Equatable {
  const StopSearchState();

  @override
  List<Object> get props => [];
}

class StopSearchInitial extends StopSearchState {}

class SearchTermChanged extends StopSearchState {
  SearchTermChanged(this.searchTerm);

  final String searchTerm;

  @override
  List<Object> get props => [
        searchTerm,
      ];
}
