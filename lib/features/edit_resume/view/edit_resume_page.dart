import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/resume.dart';
import 'package:helperr/features/edit_resume/cubit/edit_resume_cubit.dart';
import 'package:helperr/features/edit_resume/view/edit_resume_view.dart';

class EditResumePage extends StatelessWidget {
  EditResumePage({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.resume,
  }) : super(key: key);

  final VoidCallback onSave;
  final bool isEditing;
  final Resume resume;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditResumeCubit(),
      child: EditResumeView(
        onSave: onSave,
        isEditing: isEditing,
        resume: resume,
      ),
    );
  }
}
