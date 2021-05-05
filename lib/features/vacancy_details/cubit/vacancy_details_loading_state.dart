part of 'vacancy_details_loading_cubit.dart';

abstract class VacancyDetailsLoadingState extends Equatable {
  const VacancyDetailsLoadingState();

  @override
  List<Object> get props => [];
}

class VacancyDetailsLoadingInitial extends VacancyDetailsLoadingState {}

class VacancyLoadInProgress extends VacancyDetailsLoadingState {}

class VacancyLoadSuccess extends VacancyDetailsLoadingState {
  const VacancyLoadSuccess(this.vacancy);

  final Vacancy vacancy;

  @override
  String toString() => 'Vacancy state for id ${vacancy.id}';

  @override
  List<Object> get props => [vacancy];
}

class VacancyLoadFailure extends VacancyDetailsLoadingState {
  const VacancyLoadFailure(this.error);

  final dynamic error;

  @override
  List<Object> get props => [error];
}
