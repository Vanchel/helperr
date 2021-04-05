import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'worker_response_form_view.dart';
import '../cubit/worker_response_cubit.dart';
import '../../../../../data_layer/model/resume.dart';

class WorkerResponseForm extends StatelessWidget {
  const WorkerResponseForm({
    Key key,
    @required VoidCallback onSave,
    @required int vacancyId,
    @required int employerId,
    @required List<Resume> resumes,
  })  : assert(vacancyId != null),
        assert(employerId != null),
        assert(resumes != null),
        _onSave = onSave,
        _vacancyId = vacancyId,
        _employerId = employerId,
        _resumes = resumes,
        super(key: key);

  final VoidCallback _onSave;
  final int _vacancyId;
  final int _employerId;
  final List<Resume> _resumes;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkerResponseCubit(),
      child: WorkerResponseFormView(
        onSave: _onSave,
        vacancyId: _vacancyId,
        employerId: _employerId,
        resumes: _resumes,
      ),
    );
  }
}
