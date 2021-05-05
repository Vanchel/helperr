import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_employer_profile/view/edit_employer_profile_page.dart';
import 'package:helperr/features/edit_vacancy/view/vacancies_list.dart';
import 'package:helperr/features/profile_images/employer/view/employer_avatar_widget.dart';
import 'package:helperr/widgets/error_screen/error_indicator.dart';
import 'package:helperr/widgets/loading_screen.dart';
import 'package:helperr/widgets/profile_card.dart';
import '../cubit/profile_cubit.dart';
import 'package:helperr/constants.dart' as constants;

class EmployerProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileCubit = BlocProvider.of<ProfileCubit>(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadInProgress) {
          return const LoadingScreen();
        } else if (state is ProfileLoadFailure) {
          return ErrorIndicator(
            error: state.error,
            onTryAgain: () => profileCubit.loadProfile(),
          );
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

          final header = EmployerAvatar(
            employer: profile,
            onChanged: () => profileCubit.loadProfile(),
          );

          final profileCard = Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ProfileCard(
              header: header,
              name: profile.name,
              address: profile.address.name,
              description: profile.about,
              onEdit: onEdit,
            ),
          );

          final vacanciesList = VacanciesList(
            state.employerInfo.vacancies,
            onChanged: () => profileCubit.loadProfile(),
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(constants.scaffoldBodyPadding),
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
