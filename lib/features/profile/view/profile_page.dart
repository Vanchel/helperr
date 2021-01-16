import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/profile/cubit/profile_cubit.dart';
import 'package:helperr/features/profile/view/profile_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage(this.userId);

  final int userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(userId: userId)..loadProfile(),
      child: ProfileView(),
    );
  }
}
