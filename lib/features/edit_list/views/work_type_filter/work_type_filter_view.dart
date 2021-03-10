import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/work_type_cubit.dart';
import '../../../../data_layer/model/work_type.dart';

class WorkTypeFilterView extends StatelessWidget {
  const WorkTypeFilterView({Key key, @required this.onChanged})
      : super(key: key);

  final Function(Set<WorkType>) onChanged;

  void _onSelected(BuildContext context, bool isSelected, WorkType type) {
    final cubit = context.read<WorkTypeCubit>();
    isSelected ? cubit.addValue(type) : cubit.deleteValue(type);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkTypeCubit, Set<WorkType>>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        return Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            FilterChip(
              label: Text('Полный день'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(WorkType.fullDay),
              onSelected: (value) {
                _onSelected(context, value, WorkType.fullDay);
              },
            ),
            FilterChip(
              label: Text('Неполный день'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(WorkType.partDay),
              onSelected: (value) {
                _onSelected(context, value, WorkType.partDay);
              },
            ),
            FilterChip(
              label: Text('Полная занятость'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(WorkType.fullTime),
              onSelected: (value) {
                _onSelected(context, value, WorkType.fullTime);
              },
            ),
            FilterChip(
              label: Text('Неполная занятость'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(WorkType.partTime),
              onSelected: (value) {
                _onSelected(context, value, WorkType.partTime);
              },
            ),
            FilterChip(
              label: Text('Волонтерство'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(WorkType.volunteer),
              onSelected: (value) {
                _onSelected(context, value, WorkType.volunteer);
              },
            ),
            FilterChip(
              label: Text('Разовое задание'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(WorkType.oneTimeJob),
              onSelected: (value) {
                _onSelected(context, value, WorkType.oneTimeJob);
              },
            ),
            FilterChip(
              label: Text('Гибкий график'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(WorkType.flexibleSchedule),
              onSelected: (value) {
                _onSelected(context, value, WorkType.flexibleSchedule);
              },
            ),
            FilterChip(
              label: Text('Сменный график'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(WorkType.shiftSchedule),
              onSelected: (value) {
                _onSelected(context, value, WorkType.shiftSchedule);
              },
            ),
            FilterChip(
              label: Text('Вахтовый метод'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(WorkType.shiftMethod),
              onSelected: (value) {
                _onSelected(context, value, WorkType.shiftMethod);
              },
            ),
            FilterChip(
              label: Text('Удаленная работа'),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              selected: state.contains(WorkType.remote),
              onSelected: (value) {
                _onSelected(context, value, WorkType.remote);
              },
            ),
          ],
        );
      },
    );
  }
}
