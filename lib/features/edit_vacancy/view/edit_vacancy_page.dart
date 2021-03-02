import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/vacancy.dart';

import '../cubit/edit_vacancy_cubit.dart';
import 'edit_vacancy_view.dart';

class EditVacancyPage extends StatelessWidget {
  EditVacancyPage({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.vacancy,
  }) : super(key: key);

  final VoidCallback onSave;
  final bool isEditing;
  final Vacancy vacancy;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditVacancyCubit(),
      child: EditVacancyView(
        onSave: onSave,
        isEditing: isEditing,
        vacancy: vacancy,
      ),
    );
  }
}
