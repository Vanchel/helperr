import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'select_resume_view.dart';
import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/resume.dart';

class SelectResume extends StatelessWidget {
  const SelectResume({
    Key key,
    this.resumes = const [],
    this.onChanged,
  }) : super(key: key);

  final List<Resume> resumes;
  final Function(Resume) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSingleValueCubit<Resume>(null),
      child: ResumesDropdownButton(
        resumes: resumes,
        onChanged: onChanged,
      ),
    );
  }
}
