import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/vacancy.dart';

class VacanciesDropdownButton extends StatelessWidget {
  const VacanciesDropdownButton({
    Key key,
    this.vacancies,
    @required this.onChanged,
  }) : super(key: key);

  final List<Vacancy> vacancies;
  final Function(Vacancy) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSingleValueCubit<Vacancy>, Vacancy>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        final dropdownValue = state;

        return DropdownButtonFormField<Vacancy>(
          decoration: InputDecoration(
            labelText: 'Вакансия',
            hintText: 'Выберите вакансию',
            helperText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
          value: dropdownValue,
          isExpanded: true,
          onChanged: (value) =>
              context.read<EditSingleValueCubit<Vacancy>>().changeValue(value),
          validator: (value) => (value == null) ? 'Вакансия не выбрана' : null,
          items: List.generate(
            vacancies.length,
            (index) {
              return DropdownMenuItem<Vacancy>(
                value: vacancies[index],
                child: Text(vacancies[index].vacancyName),
              );
            },
          ),
        );
      },
    );
  }
}
