import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'work_type_filter_view.dart';
import '../../cubit/edit_set_cubit.dart';
import '../../../../data_layer/model/work_type.dart';

class WorkTypeFilter extends StatelessWidget {
  const WorkTypeFilter({
    Key key,
    this.initialValue = const {},
    this.onChanged,
  }) : super(key: key);

  final Set<WorkType> initialValue;
  final Function(Set<WorkType> newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSetCubit<WorkType>(initialValue),
      child: WorkTypeFilterView(onChanged: onChanged),
    );
  }
}
