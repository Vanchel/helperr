import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'select_vacancy_view.dart';
import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/vacancy.dart';

class SelectVacancy extends StatelessWidget {
  const SelectVacancy({
    Key key,
    this.vacancies = const [],
    this.onChanged,
  }) : super(key: key);

  final List<Vacancy> vacancies;
  final Function(Vacancy) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSingleValueCubit<Vacancy>(null),
      child: VacanciesDropdownButton(
        vacancies: vacancies,
        onChanged: onChanged,
      ),
    );
  }
}
