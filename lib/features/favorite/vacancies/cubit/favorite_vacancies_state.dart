part of 'favorite_vacancies_cubit.dart';

abstract class FavoriteVacanciesState extends Equatable {
  const FavoriteVacanciesState();

  @override
  List<Object> get props => [];
}

class VacanciesFetchSuccessState extends FavoriteVacanciesState {
  const VacanciesFetchSuccessState({
    this.itemList,
    this.nextPageUri,
  });

  final List<TruncatedVacancy> itemList;
  final String nextPageUri;

  @override
  String toString() {
    return 'Favorite vacancies fetch success';
  }

  @override
  List<Object> get props => [itemList, nextPageUri];
}

class VacanciesFetchFailureState extends FavoriteVacanciesState {
  const VacanciesFetchFailureState({this.error});

  final dynamic error;

  @override
  List<Object> get props => [error];
}

class VacanciesFetchInProgressState extends FavoriteVacanciesState {
  const VacanciesFetchInProgressState();
}
