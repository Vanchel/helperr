import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/edit_set_cubit.dart';
import '../../../../data_layer/model/experience_type.dart';

class ExperienceTypeFilterView extends StatelessWidget {
  const ExperienceTypeFilterView({Key key, @required this.onChanged})
      : super(key: key);

  final Function(Set<ExperienceType>) onChanged;

  void _onSelected(BuildContext context, bool isSelected, ExperienceType type) {
    final cubit = context.read<EditSetCubit<ExperienceType>>();
    isSelected ? cubit.addValue(type) : cubit.deleteValue(type);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSetCubit<ExperienceType>, Set<ExperienceType>>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        return Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            FilterChip(
              label: Text('Стажер'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(ExperienceType.internship),
              onSelected: (value) {
                _onSelected(context, value, ExperienceType.internship);
              },
            ),
            FilterChip(
              label: Text('Младший специалист'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(ExperienceType.junior),
              onSelected: (value) {
                _onSelected(context, value, ExperienceType.junior);
              },
            ),
            FilterChip(
              label: Text('Средний специалист'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(ExperienceType.middle),
              onSelected: (value) {
                _onSelected(context, value, ExperienceType.middle);
              },
            ),
            FilterChip(
              label: Text('Старший специалист'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(ExperienceType.senior),
              onSelected: (value) {
                _onSelected(context, value, ExperienceType.senior);
              },
            ),
            FilterChip(
              label: Text('Руководитель'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(ExperienceType.director),
              onSelected: (value) {
                _onSelected(context, value, ExperienceType.director);
              },
            ),
            FilterChip(
              label: Text('Старший руководитель'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(ExperienceType.seniorDirector),
              onSelected: (value) {
                _onSelected(context, value, ExperienceType.seniorDirector);
              },
            ),
          ],
        );
      },
    );
  }
}
