import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data_layer/model/models.dart';
import '../../../data_layer/data_provider/helperr_server.dart' as server;

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  int _page = 0;

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    final currentState = state;
    if (event is SearchFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is SearchInitial) {
          final results = await server.searchVacancies(_page);
          yield SearchSuccess(searchResults: results, hasReachedMax: false);
          _page++;
          return;
        }
        if (currentState is SearchSuccess) {
          final results = await server.searchVacancies(_page);
          if (results.isNotEmpty) {
            yield SearchSuccess(
              searchResults: currentState.searchResults + results,
              hasReachedMax: false,
            );
            _page++;
          } else {
            yield currentState.copyWith(hasReachedMax: true);
          }
        }
      } catch (_) {
        yield SearchFailure();
      }
    }
  }

  bool _hasReachedMax(SearchState state) =>
      state is SearchSuccess && state.hasReachedMax;
}
