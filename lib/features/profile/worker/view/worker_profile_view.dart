import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_resume/view/resumes_list.dart';
import 'package:helperr/features/edit_worker_profile/view/edit_worker_profile_page.dart';
import 'package:helperr/widgets/error_screen.dart';
import 'package:helperr/widgets/loading_screen.dart';
import 'package:helperr/widgets/profile_card.dart';
import '../cubit/profile_cubit.dart';
import 'package:helperr/constants.dart' as constants;

class WorkerProfileView extends StatelessWidget {
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
          final profile = state.workerInfo.worker;

          final onEdit = () {
            Navigator.push(
              context,
              MaterialPageRoute<EditWorkerProfilePage>(builder: (context) {
                return EditWorkerProfilePage(
                  worker: profile.copyWith(),
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
              avatarUrl: state.workerInfo.avatarUrl,
              backgroundUrl: state.workerInfo.bgUrl,
              dateOfBirth: profile.birthday,
              sex: profile.gender,
              region: profile.city,
              country: profile.cz,
              onEdit: onEdit,
              onImageChanged: () => profileCubit.loadProfile(),
            ),
          );

          final resumesList = ResumesList(
            state.workerInfo.resumes,
            onChanged: () => profileCubit.loadProfile(),
          );

          return SingleChildScrollView(
            padding:
                const EdgeInsets.all(constants.DEFAULT_SCAFFOLD_BODY_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [profileCard, resumesList],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
