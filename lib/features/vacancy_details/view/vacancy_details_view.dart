import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/vacancy_details/cubit/vacancy_details_cubit.dart';
import 'package:helperr/widgets/loading_screen.dart';

import '../../../widgets/error_screen.dart';
import '../../../constants.dart' as c;

class VacancyDetailsView extends StatelessWidget {
  const VacancyDetailsView({
    Key key,
    this.vacancyName,
    this.isResponded,
    this.isInFavorite,
  }) : super(key: key);

  final String vacancyName;
  final bool isResponded;
  final bool isInFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          splashRadius: c.iconButtonSplashRadius,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(vacancyName),
      ),
      body: BlocBuilder<VacancyDetailsCubit, VacancyDetailsState>(
        builder: (context, state) {
          if (state is VacancyLoadFailure) {
            return ErrorScreen(
              onRetry: () => context.read<VacancyDetailsCubit>().loadVacancy(),
            );
          } else if (state is VacancyLoadSuccess) {
            return Center(
              child: Text('А вот тут что-то загрузилось!  Начнем отсюда'),
            );
          } else {
            return const LoadingScreen();
          }
        },
      ),
    );
  }
}
