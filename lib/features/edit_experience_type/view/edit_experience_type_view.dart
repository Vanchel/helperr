import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:helperr/features/edit_experience_type/cubit/edit_experience_type_cubit.dart';

class ExperienceDropdownButton extends StatelessWidget {
  const ExperienceDropdownButton({Key key, @required this.onChanged})
      : super(key: key);

  final Function(ExperienceType) onChanged;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<EditExperienceTypeCubit, ExperienceType>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        final dropdownValue = state;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Тип', style: themeData.textTheme.subtitle1),
            DropdownButton<ExperienceType>(
              value: dropdownValue,
              isExpanded: true,
              onChanged: (value) => context
                  .read<EditExperienceTypeCubit>()
                  .changeExperienceType(value),
              items: const [
                DropdownMenuItem<ExperienceType>(
                  value: ExperienceType.internship,
                  child: Text('Стажировка'),
                ),
                DropdownMenuItem<ExperienceType>(
                  value: ExperienceType.junior,
                  child: Text('Младший специалист'),
                ),
                DropdownMenuItem<ExperienceType>(
                  value: ExperienceType.middle,
                  child: Text('Средний специалист'),
                ),
                DropdownMenuItem<ExperienceType>(
                  value: ExperienceType.senior,
                  child: Text('Старший специалист'),
                ),
                DropdownMenuItem<ExperienceType>(
                  value: ExperienceType.director,
                  child: Text('Руководитель'),
                ),
                DropdownMenuItem<ExperienceType>(
                  value: ExperienceType.seniorDirector,
                  child: Text('Старший руководитель'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
