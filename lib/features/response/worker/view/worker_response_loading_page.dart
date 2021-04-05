import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'worker_response_loading_view.dart';
import '../cubit/load_resumes_cubit.dart';
import '../../../../data_layer/repository/authentication_repository.dart';

class WorkerResponsePage extends StatelessWidget {
  const WorkerResponsePage({
    Key key,
    @required VoidCallback onSave,
    @required int vacancyId,
    @required int employerId,
  })  : assert(onSave != null),
        assert(vacancyId != null),
        assert(employerId != null),
        _onSave = onSave,
        _vacancyId = vacancyId,
        _employerId = employerId,
        super(key: key);

  final VoidCallback _onSave;
  final int _vacancyId;
  final int _employerId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadResumesCubit(
        RepositoryProvider.of<AuthenticationRepository>(context).user.id,
      )..loadResumes(),
      child: WorkerResponseView(
        onSave: _onSave,
        vacancyId: _vacancyId,
        employerId: _employerId,
      ),
    );
  }
}
