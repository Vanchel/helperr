part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchFailure extends SearchState {}

class SearchSuccess extends SearchState {
  final List<TruncatedVacancy> searchResults;
  final bool hasReachedMax;

  const SearchSuccess({
    this.searchResults,
    this.hasReachedMax,
  });

  SearchSuccess copyWith({
    List<TruncatedVacancy> searchResults,
    bool hasReachedMax,
  }) {
    return SearchSuccess(
      searchResults: searchResults ?? this.searchResults,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [searchResults, hasReachedMax];

  @override
  String toString() => 'SearchSuccess { searchResults: ${searchResults.length},'
      ' hasReachedMax: $hasReachedMax }';
}
