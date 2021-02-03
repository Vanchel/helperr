import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:helperr/features/edit_education_type/cubit/edit_education_type_cubit.dart';

class EducationDropdownButton extends StatelessWidget {
  const EducationDropdownButton({Key key, @required this.onChanged})
      : super(key: key);

  final Function(EducationType) onChanged;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<EditEducationTypeCubit, EducationType>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        final dropdownValue = state;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Тип', style: themeData.textTheme.subtitle1),
            DropdownButton<EducationType>(
              value: dropdownValue,
              isExpanded: true,
              onChanged: (value) => context
                  .read<EditEducationTypeCubit>()
                  .changeEducationType(value),
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
            ),
          ],
        );
      },
    );
  }
}
