import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'experience_duration_filter_view.dart';
import '../../cubit/edit_set_cubit.dart';
import '../../../../data_layer/model/experience_duration.dart';

class ExperienceDurationFilter extends StatelessWidget {
  const ExperienceDurationFilter({
    Key key,
    this.initialValue = const {},
    this.onChanged,
  }) : super(key: key);

  final Set<ExperienceDuration> initialValue;
  final Function(Set<ExperienceDuration> newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSetCubit<ExperienceDuration>(initialValue),
      child: ExperienceDurationFilterView(onChanged: onChanged),
    );
  }
}
