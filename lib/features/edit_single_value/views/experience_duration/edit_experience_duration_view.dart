import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/experience_duration.dart';

class ExperienceDurationDropdownButton extends StatelessWidget {
  const ExperienceDurationDropdownButton({Key key, @required this.onChanged})
      : super(key: key);

  final Function(ExperienceDuration) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSingleValueCubit<ExperienceDuration>,
        ExperienceDuration>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        final dropdownValue = state;

        return DropdownButtonFormField<ExperienceDuration>(
          decoration: InputDecoration(
            labelText: 'Опыт работы',
            hintText: 'Выберите стаж',
            helperText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
          value: dropdownValue,
          isExpanded: true,
          onChanged: (value) {
            context
                .read<EditSingleValueCubit<ExperienceDuration>>()
                .changeValue(value);
          },
          items: const [
            DropdownMenuItem<ExperienceDuration>(
              value: ExperienceDuration.noExperience,
              child: Text('без опыта работы'),
            ),
            DropdownMenuItem<ExperienceDuration>(
              value: ExperienceDuration.lessThanYear,
              child: Text('менее года'),
            ),
            DropdownMenuItem<ExperienceDuration>(
              value: ExperienceDuration.oneToThreeYears,
              child: Text('1-3 года'),
            ),
            DropdownMenuItem<ExperienceDuration>(
              value: ExperienceDuration.threeToFiveYears,
              child: Text('3-5 лет'),
            ),
            DropdownMenuItem<ExperienceDuration>(
              value: ExperienceDuration.moreThanFiveYears,
              child: Text('более 5 лет'),
            ),
          ],
        );
      },
    );
  }
}
