part of 'vacancy_details_cubit.dart';

abstract class VacancyDetailsState extends Equatable {
  const VacancyDetailsState();

  @override
  List<Object> get props => [];
}

class VacancyDetailsInitial extends VacancyDetailsState {}

class VacancyLoadInProgress extends VacancyDetailsState {}

class VacancyLoadSuccess extends VacancyDetailsState {
  const VacancyLoadSuccess(this.vacancy);

  final Vacancy vacancy;

  @override
  List<Object> get props => [vacancy];
}

class VacancyLoadFailure extends VacancyDetailsState {}
