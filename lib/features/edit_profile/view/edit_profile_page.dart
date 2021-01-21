import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_profile/cubit/edit_profile_cubit.dart';

import 'edit_profile_view.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage(this.userId);

  final userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(userId: userId)..loadProfile(),
      child: EditProfileView(),
    );
  }
}
