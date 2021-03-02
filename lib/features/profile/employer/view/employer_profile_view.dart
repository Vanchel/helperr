import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_employer_profile/view/edit_employer_profile_page.dart';
import 'package:helperr/features/edit_vacancy/view/vacancies_list.dart';
import 'package:helperr/widgets/error_screen.dart';
import 'package:helperr/widgets/loading_screen.dart';
import 'package:helperr/widgets/profile_card.dart';
import '../cubit/profile_cubit.dart';

class EmployerProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileCubit = BlocProvider.of<ProfileCubit>(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadInProgress) {
          return const LoadingScreen();
        } else if (state is ProfileLoadFailure) {
          return ErrorScreen(onRetry: () => profileCubit.loadProfile());
        } else if (state is ProfileLoadSuccess) {
          final profile = state.employerInfo.employer;

          final onEdit = () {
            Navigator.push(
              context,
              MaterialPageRoute<EditEmployerProfilePage>(builder: (context) {
                return EditEmployerProfilePage(
                  employer: profile.copyWith(),
                  onSave: () => profileCubit.loadProfile(),
                );
              }),
            );
          };

          final profileCard = Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ProfileCard(
              userId: profile.userId,
              name: profile.name,
              description: profile.about,
              avatarUrl: state.employerInfo.avatarUrl,
              backgroundUrl: state.employerInfo.bgUrl,
              onEdit: onEdit,
              onImageChanged: () => profileCubit.loadProfile(),
            ),
          );

          final vacanciesList = VacanciesList(
            state.employerInfo.vacancies,
            onChanged: () => profileCubit.loadProfile(),
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [profileCard, vacanciesList],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
