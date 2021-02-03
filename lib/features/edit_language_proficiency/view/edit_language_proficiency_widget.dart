import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:helperr/features/edit_language_proficiency/cubit/edit_language_proficiency_cubit.dart';
import 'package:helperr/features/edit_language_proficiency/view/edit_language_proficiency_view.dart';

class EditLanguageProficiency extends StatelessWidget {
  const EditLanguageProficiency(
      {Key key, this.initialValue = LanguageProficiency.a1, this.onChanged})
      : super(key: key);

  final LanguageProficiency initialValue;
  final Function(LanguageProficiency) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditLanguageProficiencyCubit(initialValue),
      child: LanguageProficiencyDropdownButton(onChanged: onChanged),
    );
  }
}
