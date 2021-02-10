import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_profile/view/edit_profile_page.dart';
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
      } else if (state is ProfileLoadFailure) {
        return ErrorScreen(onRetry: () => profileCubit.loadProfile());
      } else if (state is ProfileLoadSuccess) {
        final profile = state.workerInfo.worker;

        final profileCard = ProfileCard(
          name: profile.name,
          description: profile.about,
          backgroundUrl: profile.profileBackground,
          avatarUrl: profile.photoUrl,
          dateOfBirth: profile.birthday,
          sex: profile.gender,
          region: profile.city,
          country: profile.cz,
        );

        final editButton = Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          child: OutlinedButton(
            child: const Text('Редактировать профиль'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<EditProfilePage>(builder: (context) {
                  return EditProfilePage(
                    worker: profile.copyWith(),
                    onSave: () => profileCubit.loadProfile(),
                  );
                }),
              );
            },
          ),
        );

        final resumesList = const Text('уже совсем скоро тут будут резюме');

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              profileCard,
              editButton,
              resumesList,
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
