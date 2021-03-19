import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:helperr/data_layer/model/vacancy_search_options.dart';
import 'package:helperr/data_layer/model/truncated_vacancy.dart';
import '../../../../data_layer/data_provider/helperr_server.dart' as server;
import 'package:meta/meta.dart';

part 'search_state.dart';

class VacancySearchCubit extends Cubit<SearchState> {
  VacancySearchCubit({@required this.searchOptions}) : super(SearchInitial());

  final VacancySearchOptions searchOptions;

  int _page = 1;

  void fetchResults() async {
    final currentState = state;
    if (!_hasReachedMax(state)) {
      try {
        if (currentState is SearchInitial) {
          final results = await server.searchVacancies(
            _page,
            options: searchOptions,
          );
          emit(SearchSuccess(searchResults: results, hasReachedMax: false));
          _page++;
          return;
        }
        if (currentState is SearchSuccess) {
          final results = await server.searchVacancies(
            _page,
            options: searchOptions,
          );
          if (results.isNotEmpty) {
            final newState = SearchSuccess(
              searchResults: currentState.searchResults + results,
              hasReachedMax: false,
            );
            emit(newState);
            _page++;
          } else {
            emit(currentState.copyWith(hasReachedMax: true));
          }
        }
      } catch (e) {
        print(e);
        emit(SearchFailure());
      }
    }
  }

  bool _hasReachedMax(SearchState state) =>
      state is SearchSuccess && state.hasReachedMax;
}
