import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'employer_response_form_view.dart';
import '../cubit/employer_response_cubit.dart';
import '../../../../../data_layer/model/vacancy.dart';

class EmployerResponseForm extends StatelessWidget {
  const EmployerResponseForm({
    Key key,
    @required VoidCallback onSave,
    @required int resumeId,
    @required int workerId,
    @required List<Vacancy> vacancies,
  })  : assert(resumeId != null),
        assert(workerId != null),
        assert(vacancies != null),
        _onSave = onSave,
        _resumeId = resumeId,
        _workerId = workerId,
        _vacancies = vacancies,
        super(key: key);

  final VoidCallback _onSave;
  final int _resumeId;
  final int _workerId;
  final List<Vacancy> _vacancies;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployerResponseCubit(),
      child: EmployerResponseFormView(
        onSave: _onSave,
        resumeId: _resumeId,
        workerId: _workerId,
        vacancies: _vacancies,
      ),
    );
  }
}
