import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'vacancy_details_view.dart';
import '../cubit/vacancy_details_cubit.dart';

class VacancyDetailsPage extends StatelessWidget {
  const VacancyDetailsPage({
    Key key,
    // TODO: уточнить подробнее, а лучше вынести этот кусочек с ифнормацией
    // о профиле в отдельный виджет
    @required this.vacancyName,
    @required this.vacancyId,
    this.isResponded = false,
    this.isInFavorite = false,
  })  : assert(vacancyName != null),
        assert(vacancyId != null),
        assert(isResponded != null),
        assert(isInFavorite != null),
        super(key: key);

  final String vacancyName;
  final int vacancyId;
  final bool isResponded;
  final bool isInFavorite;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VacancyDetailsCubit(vacancyId)..loadVacancy(),
      child: VacancyDetailsView(
        vacancyName: vacancyName,
        isResponded: isResponded,
        isInFavorite: isInFavorite,
      ),
    );
  }
}
