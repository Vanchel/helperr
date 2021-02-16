import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/worker.dart';

class ExperienceDropdownButton extends StatelessWidget {
  const ExperienceDropdownButton({Key key, @required this.onChanged})
      : super(key: key);

  final Function(ExperienceType) onChanged;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<EditSingleValueCubit<ExperienceType>, ExperienceType>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        final dropdownValue = state;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Степень опытности', style: themeData.textTheme.bodyText1),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.fromLTRB(11.0, 4.0, 17.0, 4.0),
              decoration: BoxDecoration(
                color: themeData.canvasColor,
                border: const Border.fromBorderSide(
                  BorderSide(color: Colors.black38),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ExperienceType>(
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
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
