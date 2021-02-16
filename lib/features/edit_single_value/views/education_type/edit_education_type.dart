import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_education_type_view.dart';
import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/worker.dart';

class EditEducationType extends StatelessWidget {
  const EditEducationType(
      {Key key, this.initialValue = EducationType.course, this.onChanged})
      : super(key: key);

  final EducationType initialValue;
  final Function(EducationType) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSingleValueCubit<EducationType>(initialValue),
      child: EducationDropdownButton(onChanged: onChanged),
    );
  }
}
