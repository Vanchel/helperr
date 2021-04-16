import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorite_vacancies_view.dart';
import '../cubit/favorite_vacancies_cubit.dart';

class FavoriteVacanciesPage extends StatelessWidget {
  const FavoriteVacanciesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteVacanciesCubit(),
      child: FavoriteVacanciesView(),
    );
  }
}
