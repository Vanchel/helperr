import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_experience_type_view.dart';
import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/experience_type.dart';

class EditExperienceType extends StatelessWidget {
  const EditExperienceType({
    Key key,
    this.initialValue = ExperienceType.internship,
    this.onChanged,
  }) : super(key: key);

  final ExperienceType initialValue;
  final Function(ExperienceType) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSingleValueCubit<ExperienceType>(initialValue),
      child: ExperienceTypeDropdownButton(onChanged: onChanged),
    );
  }
}
