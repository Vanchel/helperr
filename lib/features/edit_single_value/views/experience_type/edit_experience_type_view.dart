import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/experience_type.dart';

class ExperienceTypeDropdownButton extends StatelessWidget {
  const ExperienceTypeDropdownButton({Key key, @required this.onChanged})
      : super(key: key);

  final Function(ExperienceType) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSingleValueCubit<ExperienceType>, ExperienceType>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        final dropdownValue = state;

        return DropdownButtonFormField<ExperienceType>(
          decoration: InputDecoration(
            labelText: 'Степень опытности',
            hintText: 'Выберите степень опытности в профессии',
            helperText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
          value: dropdownValue,
          isExpanded: true,
          onChanged: (value) {
            context
                .read<EditSingleValueCubit<ExperienceType>>()
                .changeValue(value);
          },
          items: const [
            DropdownMenuItem<ExperienceType>(
              value: ExperienceType.internship,
              child: Text('Стажер'),
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
        );
      },
    );
  }
}
