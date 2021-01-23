import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_profile/edit_profile_page.dart';
import 'package:helperr/widgets/error_screen.dart';
import 'package:helperr/widgets/loading_screen.dart';
import 'package:helperr/widgets/profile_card.dart';
import '../cubit/profile_cubit.dart';
import '../profile.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileCubit = BlocProvider.of<ProfileCubit>(context);

    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      if (state is ProfileLoadInProgress) {
        return const LoadingScreen();
      }
      if (state is ProfileLoadFailure) {
        return ErrorScreen(onRetry: () => profileCubit.loadProfile());
      }
      if (state is ProfileLoadSuccess) {
        final profileCard = ProfileCard(
          name: state.worker.name,
          description: state.worker.about,
          backgroundUrl: state.worker.profileBackground,
          avatarUrl: state.worker.photoUrl,
          dateOfBirth: state.worker.birthday,
          region: state.worker.city,
          country: state.worker.cz,
        );

        final editButton = Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          child: OutlinedButton(
            child: const Text('Редактировать профиль'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<EditProfilePage>(builder: (context) {
                  return BlocProvider.value(
                    value: profileCubit,
                    child: EditProfilePage(
                      worker: state.worker,
                      onSave: () => profileCubit.loadProfile(),
                    ),
                  );
                }),
              );
            },
          ),
        );

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              profileCard,
              editButton,
            ],
          ),
        );
      }
      return Container();
    });
  }
}
