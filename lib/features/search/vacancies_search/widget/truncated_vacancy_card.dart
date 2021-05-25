import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/truncated_vacancy.dart';

import '../../cubit/card_actions_cubit.dart';
import 'truncated_vacancy_card_view.dart';

class TruncatedVacancyCard extends StatelessWidget {
  const TruncatedVacancyCard({Key key, @required this.vacancy})
      : super(key: key);

  final TruncatedVacancy vacancy;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardActionsCubit(
        responded: vacancy.gotResponsed,
        favorited: vacancy.favorited,
      ),
      child: TruncatedVacancyCardView(vacancy: vacancy),
    );
  }
}
