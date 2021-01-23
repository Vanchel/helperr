import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/repository/authentication_repository.dart';
import 'package:helperr/features/profile/cubit/profile_cubit.dart';
import 'package:helperr/features/profile/view/profile_view.dart';

import '../../settings/view/settings_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            splashRadius: 24.0,
            onPressed: () => Navigator.push(context, SettingsPage.route()),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit(
            user: RepositoryProvider.of<AuthenticationRepository>(context).user)
          ..loadProfile(),
        child: ProfileView(),
      ),
    );
  }
}
