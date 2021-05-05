import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/widgets/custom_back_button.dart';
import 'package:helperr/widgets/error_screen/error_indicator.dart';

import '../cubit/load_vacancies_cubit.dart';
import '../employer_response_form/view/employer_response_form.dart';
import '../../../../widgets/loading_screen.dart';
import '../../../../constants.dart' as c;

class EmployerResponseView extends StatelessWidget {
  const EmployerResponseView({
    Key key,
    this.onSave,
    this.resumeId,
    this.workerId,
  }) : super(key: key);

  final VoidCallback onSave;
  final int resumeId;
  final int workerId;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Пригласить'),
      leading: const CustomBackButton(),
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

    return BlocBuilder<LoadVacanciesCubit, LoadVacanciesState>(
      builder: (context, state) {
        if (state is VacanciesLoadSuccess) {
          return EmployerResponseForm(
            onSave: onSave,
            resumeId: resumeId,
            workerId: workerId,
            vacancies: state.vacancies,
          );
        } else if (state is VacanciesLoadFailure) {
          return Scaffold(
            appBar: appBar,
            body: ErrorIndicator(
              error: state.error,
              onTryAgain: () =>
                  context.read<LoadVacanciesCubit>().loadVacancies(),
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
