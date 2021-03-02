import 'package:equatable/equatable.dart';

import 'employer.dart';
import 'vacancy.dart';

class EmployerInfo extends Equatable {
  EmployerInfo(this.employer, this.vacancies, this.avatarUrl, this.bgUrl);

  final Employer employer;
  final List<Vacancy> vacancies;

  final String avatarUrl;
  final String bgUrl;

  EmployerInfo copyWith({
    Employer employer,
    List<Vacancy> vacancies,
    String avatarUrl,
    String bgUrl,
  }) =>
      EmployerInfo(
        employer ?? this.employer,
        vacancies ?? this.vacancies,
        avatarUrl ?? this.avatarUrl,
        bgUrl ?? this.bgUrl,
      );

  @override
  List<Object> get props => [employer, vacancies, avatarUrl, bgUrl];
}
