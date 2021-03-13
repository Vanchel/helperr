import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/edit_set_cubit.dart';
import '../../../../data_layer/model/experience_duration.dart';

class ExperienceDurationFilterView extends StatelessWidget {
  const ExperienceDurationFilterView({Key key, @required this.onChanged})
      : super(key: key);

  final Function(Set<ExperienceDuration>) onChanged;

  void _onSelected(
    BuildContext context,
    bool isSelected,
    ExperienceDuration duration,
  ) {
    final cubit = context.read<EditSetCubit<ExperienceDuration>>();
    isSelected ? cubit.addValue(duration) : cubit.deleteValue(duration);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSetCubit<ExperienceDuration>,
        Set<ExperienceDuration>>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        return Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            FilterChip(
              label: Text('Без опыта работы'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(ExperienceDuration.noExperience),
              onSelected: (value) {
                _onSelected(context, value, ExperienceDuration.noExperience);
              },
            ),
            FilterChip(
              label: Text('Менее года'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(ExperienceDuration.lessThanYear),
              onSelected: (value) {
                _onSelected(context, value, ExperienceDuration.lessThanYear);
              },
            ),
            FilterChip(
              label: Text('1-3 года'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(ExperienceDuration.oneToThreeYears),
              onSelected: (value) {
                _onSelected(context, value, ExperienceDuration.oneToThreeYears);
              },
            ),
            FilterChip(
              label: Text('3-5 лет'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(ExperienceDuration.threeToFiveYears),
              onSelected: (value) {
                _onSelected(
                    context, value, ExperienceDuration.threeToFiveYears);
              },
            ),
            FilterChip(
              label: Text('Более 5 лет'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(ExperienceDuration.moreThanFiveYears),
              onSelected: (value) {
                _onSelected(
                    context, value, ExperienceDuration.moreThanFiveYears);
              },
            ),
          ],
        );
      },
    );
  }
}
