import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/models.dart';
import 'package:helperr/features/edit_experience_type/cubit/edit_experience_type_cubit.dart';
import 'package:helperr/features/edit_experience_type/view/edit_experience_type_view.dart';

class EditExperienceType extends StatelessWidget {
  const EditExperienceType(
      {Key key, this.initialValue = ExperienceType.internship, this.onChanged})
      : super(key: key);

  final ExperienceType initialValue;
  final Function(ExperienceType) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditExperienceTypeCubit(initialValue),
      child: ExperienceDropdownButton(onChanged: onChanged),
    );
  }
}
