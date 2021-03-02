part of 'edit_vacancy_cubit.dart';

abstract class EditVacancyState extends Equatable {
  const EditVacancyState();

  @override
  List<Object> get props => [];
}

class EditVacancyInitial extends EditVacancyState {}

class VacancyChangeInProgress extends EditVacancyState {}

class VacancyChangeSuccess extends EditVacancyState {}

class VacancyChangeFailure extends EditVacancyState {}
