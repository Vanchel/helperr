import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'employer_response_loading_view.dart';
import '../cubit/load_vacancies_cubit.dart';
import '../../../../data_layer/repository/authentication_repository.dart';

class EmployerResponsePage extends StatelessWidget {
  const EmployerResponsePage({
    Key key,
    @required VoidCallback onSave,
    @required int resumeId,
    @required int workerId,
  })  : assert(onSave != null),
        assert(resumeId != null),
        assert(resumeId != null),
        _onSave = onSave,
        _resumeId = resumeId,
        _workerId = workerId,
        super(key: key);

  final VoidCallback _onSave;
  final int _resumeId;
  final int _workerId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadVacanciesCubit(
        RepositoryProvider.of<AuthenticationRepository>(context).user.id,
      )..loadVacancies(),
      child: EmployerResponseView(
        onSave: _onSave,
        resumeId: _resumeId,
        workerId: _workerId,
      ),
    );
  }
}
