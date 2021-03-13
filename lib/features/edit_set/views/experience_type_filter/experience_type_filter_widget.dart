import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'experience_type_filter_view.dart';
import '../../cubit/edit_set_cubit.dart';
import '../../../../data_layer/model/experience_type.dart';

class ExperienceTypeFilter extends StatelessWidget {
  const ExperienceTypeFilter({
    Key key,
    this.initialValue = const {},
    this.onChanged,
  }) : super(key: key);

  final Set<ExperienceType> initialValue;
  final Function(Set<ExperienceType> newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSetCubit<ExperienceType>(initialValue),
      child: ExperienceTypeFilterView(onChanged: onChanged),
    );
  }
}
