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
    final themeData = Theme.of(context);

    return BlocBuilder<EditSingleValueCubit<ExperienceDuration>,
        ExperienceDuration>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        final dropdownValue = state;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Опыт работы', style: themeData.textTheme.bodyText1),
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
                child: DropdownButton<ExperienceDuration>(
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
                      child: Text('Без опыта работы'),
                    ),
                    DropdownMenuItem<ExperienceDuration>(
                      value: ExperienceDuration.lessThanYear,
                      child: Text('< 1 года'),
                    ),
                    DropdownMenuItem<ExperienceDuration>(
                      value: ExperienceDuration.oneToThreeYears,
                      child: Text('1 - 3 года'),
                    ),
                    DropdownMenuItem<ExperienceDuration>(
                      value: ExperienceDuration.threeToFiveYears,
                      child: Text('3 - 5 лет'),
                    ),
                    DropdownMenuItem<ExperienceDuration>(
                      value: ExperienceDuration.moreThanFiveYears,
                      child: Text('> 5 лет'),
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
