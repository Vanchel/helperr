import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_experience_duration_view.dart';
import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/experience_duration.dart';

class EditExperienceDuration extends StatelessWidget {
  const EditExperienceDuration({
    Key key,
    this.initialValue = ExperienceDuration.noExperience,
    this.onChanged,
  }) : super(key: key);

  final ExperienceDuration initialValue;
  final Function(ExperienceDuration) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditSingleValueCubit<ExperienceDuration>(initialValue),
      child: ExperienceDurationDropdownButton(onChanged: onChanged),
    );
  }
}
