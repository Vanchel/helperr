import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/language_proficiency.dart';

class LanguageProficiencyDropdownButton extends StatelessWidget {
  const LanguageProficiencyDropdownButton({Key key, @required this.onChanged})
      : super(key: key);

  final Function(LanguageProficiency) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSingleValueCubit<LanguageProficiency>,
        LanguageProficiency>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        final dropdownValue = state;

        return DropdownButtonFormField<LanguageProficiency>(
          decoration: InputDecoration(
            labelText: 'Уровень владения',
            hintText: 'Выберите уровень владения языком',
            helperText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
          value: dropdownValue,
          isExpanded: true,
          onChanged: (value) => context
              .read<EditSingleValueCubit<LanguageProficiency>>()
              .changeValue(value),
          items: const [
            DropdownMenuItem<LanguageProficiency>(
              value: LanguageProficiency.a1,
              child: Text('Начинающий'),
            ),
            DropdownMenuItem<LanguageProficiency>(
              value: LanguageProficiency.a2,
              child: Text('Предпродвинутый'),
            ),
            DropdownMenuItem<LanguageProficiency>(
              value: LanguageProficiency.b1,
              child: Text('Продвинутый'),
            ),
            DropdownMenuItem<LanguageProficiency>(
              value: LanguageProficiency.b2,
              child: Text('Предпрофессиональный'),
            ),
            DropdownMenuItem<LanguageProficiency>(
              value: LanguageProficiency.c1,
              child: Text('Профессиональный'),
            ),
            DropdownMenuItem<LanguageProficiency>(
              value: LanguageProficiency.c2,
              child: Text('Владение в совершенстве'),
            ),
          ],
        );
      },
    );
  }
}
