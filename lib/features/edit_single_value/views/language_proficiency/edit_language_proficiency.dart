import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_language_proficiency_view.dart';
import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/worker.dart';

class EditLanguageProficiency extends StatelessWidget {
  const EditLanguageProficiency(
      {Key key, this.initialValue = LanguageProficiency.a1, this.onChanged})
      : super(key: key);

  final LanguageProficiency initialValue;
  final Function(LanguageProficiency) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditSingleValueCubit<LanguageProficiency>(initialValue),
      child: LanguageProficiencyDropdownButton(onChanged: onChanged),
    );
  }
}
