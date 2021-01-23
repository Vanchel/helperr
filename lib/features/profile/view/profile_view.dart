import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/models.dart';
import 'package:helperr/data_layer/repository/authentication_repository.dart';
import 'package:helperr/features/edit_profile/view/edit_profile_page.dart';
import 'package:helperr/features/settings/view/settings_page.dart';
import 'package:helperr/widgets/profile_card.dart';
import '../cubit/profile_cubit.dart';
import '../profile.dart';

class ProfileView extends StatelessWidget {
  Widget _buildWorkerProfile(BuildContext context, Worker worker) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileCard(
            name: worker.name,
            description: worker.about,
            backgroundUrl: worker.profileBackground,
            avatarUrl: worker.photoUrl,
            dateOfBirth: worker.birthday,
            region: worker.city,
            country: worker.cz,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final onErr = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Произошла ошибка'),
        TextButton(
          child: const Text('Повторить попытку'),
          onPressed: () => context.read<ProfileCubit>().loadProfile(),
        ),
      ],
    );

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
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoadSuccess) {
            return _buildWorkerProfile(context, state.worker);
          } else if (state is ProfileLoadFailure) {
            return Center(child: onErr);
          } else {
            //must never happen
            return Container();
          }
        },
      ),
    );
  }
}
