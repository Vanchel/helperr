import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/load_resumes_cubit.dart';
import '../worker_response_form/view/worker_response_form.dart';
import '../../../../widgets/loading_screen.dart';
import '../../../../widgets/error_screen.dart';
import '../../../../constants.dart' as c;

class WorkerResponseView extends StatelessWidget {
  const WorkerResponseView({
    Key key,
    this.onSave,
    this.vacancyId,
    this.employerId,
  }) : super(key: key);

  final VoidCallback onSave;
  final int vacancyId;
  final int employerId;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Откликнуться'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        splashRadius: c.iconButtonSplashRadius,
        onPressed: () => Navigator.pop(context),
      ),
      bottom: PreferredSize(
        child: const SizedBox.shrink(),
        preferredSize: const Size.fromHeight(4.0),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.check_rounded),
          splashRadius: c.iconButtonSplashRadius,
          onPressed: null,
        ),
      ],
    );

    return BlocBuilder<LoadResumesCubit, LoadResumesState>(
      builder: (context, state) {
        if (state is ResumesLoadSuccess) {
          return WorkerResponseForm(
            onSave: onSave,
            vacancyId: vacancyId,
            employerId: employerId,
            resumes: state.resumes,
          );
        } else if (state is ResumesLoadFailure) {
          return Scaffold(
            appBar: appBar,
            body: ErrorScreen(
              onRetry: () => context.read<LoadResumesCubit>().loadResumes(),
            ),
          );
        } else {
          return Scaffold(
            appBar: appBar,
            body: const LoadingScreen(),
          );
        }
      },
    );
  }
}
