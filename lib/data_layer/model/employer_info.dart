import 'package:equatable/equatable.dart';

import 'employer.dart';
import 'vacancy.dart';

class EmployerInfo extends Equatable {
  EmployerInfo(this.employer, this.vacancies);

  final Employer employer;
  final List<Vacancy> vacancies;

  EmployerInfo copyWith({
    Employer employer,
    List<Vacancy> vacancies,
  }) =>
      EmployerInfo(
        employer ?? this.employer,
        vacancies ?? this.vacancies,
      );

  @override
  List<Object> get props => [employer, vacancies];

  @override
  String toString() => 'Employer info for id ${employer.userId}';
}
