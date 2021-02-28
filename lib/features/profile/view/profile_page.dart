import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/repository/authentication_repository.dart';
import 'package:helperr/features/profile/cubit/profile_cubit.dart';
import 'package:helperr/features/profile/view/profile_view.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        id: RepositoryProvider.of<AuthenticationRepository>(context).user.id,
      )..loadProfile(),
      child: ProfileView(),
    );
  }
}
