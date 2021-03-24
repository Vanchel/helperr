part of 'vacancy_listing_cubit.dart';

abstract class VacancyListingState extends Equatable {
  const VacancyListingState();

  @override
  List<Object> get props => [];
}

class VacanciesFetchSuccessState extends VacancyListingState {
  const VacanciesFetchSuccessState({
    this.itemList,
    this.nextPageUri,
  });

  final List<TruncatedVacancy> itemList;
  final String nextPageUri;

  @override
  List<Object> get props => [itemList, nextPageUri];
}

class VacanciesFetchFailureState extends VacancyListingState {
  const VacanciesFetchFailureState({this.error});

  final dynamic error;

  @override
  List<Object> get props => [error];
}

class VacanciesFetchInProgressState extends VacancyListingState {
  const VacanciesFetchInProgressState();
}
