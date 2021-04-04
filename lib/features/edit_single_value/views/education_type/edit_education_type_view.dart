import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/education_type.dart';

class EducationDropdownButton extends StatelessWidget {
  const EducationDropdownButton({Key key, @required this.onChanged})
      : super(key: key);

  final Function(EducationType) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSingleValueCubit<EducationType>, EducationType>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        final dropdownValue = state;

        return DropdownButtonFormField<EducationType>(
          decoration: InputDecoration(
            labelText: 'Тип',
            hintText: 'Выберите тип образования',
            helperText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
          value: dropdownValue,
          isExpanded: true,
          onChanged: (value) {
            context
                .read<EditSingleValueCubit<EducationType>>()
                .changeValue(value);
          },
          items: const [
            DropdownMenuItem<EducationType>(
              value: EducationType.course,
              child: Text('Курсы'),
            ),
            DropdownMenuItem<EducationType>(
              value: EducationType.primary,
              child: Text('Начальное (4 класса)'),
            ),
            DropdownMenuItem<EducationType>(
              value: EducationType.basic,
              child: Text('Среднее общее (9 классов)'),
            ),
            DropdownMenuItem<EducationType>(
              value: EducationType.secondary,
              child: Text('Среднее полное (11 классов)'),
            ),
            DropdownMenuItem<EducationType>(
              value: EducationType.postSecondary,
              child: Text('Среднее профессиональное'),
            ),
            DropdownMenuItem<EducationType>(
              value: EducationType.bachelor,
              child: Text('Высшее (бакалавриат)'),
            ),
            DropdownMenuItem<EducationType>(
              value: EducationType.specialist,
              child: Text('Высшее (специалитет)'),
            ),
            DropdownMenuItem<EducationType>(
              value: EducationType.magister,
              child: Text('Высшее (магистратура)'),
            ),
            DropdownMenuItem<EducationType>(
              value: EducationType.phdAsp,
              child: Text('Аспирантура'),
            ),
            DropdownMenuItem<EducationType>(
              value: EducationType.phdDoc,
              child: Text('Докторантура'),
            ),
          ],
        );
      },
    );
  }
}
