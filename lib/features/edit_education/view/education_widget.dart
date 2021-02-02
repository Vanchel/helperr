import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/models.dart';
import 'package:helperr/features/edit_education/cubit/education_cubit.dart';
import 'package:helperr/features/edit_education/view/education_view.dart';

class EducationList extends StatelessWidget {
  const EducationList({Key key, this.initialValue = const [], this.onChanged})
      : super(key: key);

  final List<Education> initialValue;
  final Function(List<Education> newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EducationCubit(initialValue),
      child: EducationView(onChanged: onChanged),
    );
  }
}
