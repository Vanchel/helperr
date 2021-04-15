import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorite_button_view.dart';
import '../cubit/favorite_cubit.dart';
import '../repository/favorite_vacancy_repository.dart';
import '../repository/favorite_resume_repository.dart';

import '../../../data_layer/repository/authentication_repository.dart';
import '../../../data_layer/model/user_type.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key key,
    @required this.id,
    @required this.isInFavorite,
  }) : super(key: key);

  final int id;
  final bool isInFavorite;

  @override
  Widget build(BuildContext context) {
    final userType =
        RepositoryProvider.of<AuthenticationRepository>(context).user.userType;
    final repository = userType == UserType.employee
        ? FavoriteVacancyRepository()
        : FavoriteResumeRepository();

    return BlocProvider(
      create: (context) => FavoriteCubit(
        id: id,
        isInFavorite: isInFavorite,
        repository: repository,
      ),
      child: FavoriteButtonView(),
    );
  }
}
