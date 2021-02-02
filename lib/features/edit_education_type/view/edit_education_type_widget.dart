import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:helperr/features/edit_education_type/cubit/edit_education_type_cubit.dart';
import 'package:helperr/features/edit_education_type/view/edit_education_type_view.dart';

class EditEducationType extends StatelessWidget {
  const EditEducationType(
      {Key key, this.initialValue = EducationType.course, this.onChanged})
      : super(key: key);

  final EducationType initialValue;
  final Function(EducationType) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditEducationTypeCubit(initialValue),
      child: EducationDropdownButton(onChanged: onChanged),
    );
  }
}
