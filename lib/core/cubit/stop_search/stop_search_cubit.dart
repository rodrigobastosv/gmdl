import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stop_search_state.dart';

class StopSearchCubit extends Cubit<StopSearchState> {
  StopSearchCubit() : super(StopSearchInitial());

  String term = '';

  void onChangeSearchTerm(String term) {
    this.term = term;
    emit(SearchTermChanged(term));
  }
}
