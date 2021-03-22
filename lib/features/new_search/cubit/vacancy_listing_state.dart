part of 'vacancy_listing_cubit.dart';

class VacancyListingState extends Equatable {
  const VacancyListingState({
    this.itemList,
    this.error,
    this.nextPageUri,
  });

  final List<TruncatedVacancy> itemList;
  final dynamic error;
  final String nextPageUri;

  @override
  List<Object> get props => [
        itemList,
        error,
        nextPageUri,
      ];
}
