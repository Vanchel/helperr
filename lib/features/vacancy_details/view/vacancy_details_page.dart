import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'vacancy_details_view.dart';
import '../cubit/vacancy_details_loading_cubit.dart';

class VacancyDetailsPage extends StatelessWidget {
  const VacancyDetailsPage({
    Key key,
    @required this.vacancyName,
    @required this.vacancyId,
    @required this.onRespond,
    @required this.onFavoriteChanged,
  })  : assert(vacancyName != null),
        assert(vacancyId != null),
        super(key: key);

  final String vacancyName;
  final int vacancyId;
  final VoidCallback onRespond;
  final void Function(bool) onFavoriteChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VacancyDetailsLoadingCubit(vacancyId)..loadVacancy(),
      child: VacancyDetailsView(
        vacancyName: vacancyName,
        onRespond: onRespond,
        onFavoriteChanged: onFavoriteChanged,
      ),
    );
  }
}
