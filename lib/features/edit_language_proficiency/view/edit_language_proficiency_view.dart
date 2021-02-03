import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:helperr/features/edit_language_proficiency/cubit/edit_language_proficiency_cubit.dart';

class LanguageProficiencyDropdownButton extends StatelessWidget {
  const LanguageProficiencyDropdownButton({Key key, @required this.onChanged})
      : super(key: key);

  final Function(LanguageProficiency) onChanged;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<EditLanguageProficiencyCubit, LanguageProficiency>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        final dropdownValue = state;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Уровень владения', style: themeData.textTheme.subtitle1),
            DropdownButton<LanguageProficiency>(
              value: dropdownValue,
              isExpanded: true,
              onChanged: (value) => context
                  .read<EditLanguageProficiencyCubit>()
                  .changeLanguageProficiency(value),
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
            ),
          ],
        );
      },
    );
  }
}
