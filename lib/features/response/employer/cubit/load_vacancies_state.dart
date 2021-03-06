part of 'load_vacancies_cubit.dart';

abstract class LoadVacanciesState extends Equatable {
  const LoadVacanciesState();

  @override
  List<Object> get props => [];
}

class VacanciesLoadInProgress extends LoadVacanciesState {}

class VacanciesLoadFailure extends LoadVacanciesState {
  const VacanciesLoadFailure(this.error);

  final dynamic error;

  @override
  List<Object> get props => [error];
}

class VacanciesLoadSuccess extends LoadVacanciesState {
  const VacanciesLoadSuccess(this.vacancies);

  final List<Vacancy> vacancies;

  @override
  String toString() => 'Successfully loaded ${vacancies.length} resumes';

  @override
  List<Object> get props => [vacancies];
}
