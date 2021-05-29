import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_resume/view/resumes_list.dart';
import 'package:helperr/features/edit_worker_profile/view/edit_worker_profile_page.dart';
import 'package:helperr/features/profile_images/worker/view/worker_avatar_widget.dart';
import 'package:helperr/widgets/error_screen/error_indicator.dart';
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
          return ErrorIndicator(
            error: state.error,
            onTryAgain: () => profileCubit.loadProfile(),
          );
        } else if (state is ProfileLoadSuccess) {
          final profile = state.workerInfo.worker;

          final onEdit = () {
            Navigator.push(
              context,
              MaterialPageRoute<EditWorkerProfilePage>(builder: (context) {
                return EditWorkerProfilePage(
                  worker: profile.copyWith(birthday: profile.birthday),
                  onSave: () => profileCubit.loadProfile(),
                );
              }),
            );
          };

          final header = WorkerAvatar(
            worker: profile,
            onChanged: () => profileCubit.loadProfile(),
          );

          final profileCard = Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ProfileCard(
              header: header,
              name: profile.name,
              description: profile.about,
              address: profile.address.name,
              onEdit: onEdit,
            ),
          );

          final resumesList = ResumesList(
            state.workerInfo.resumes,
            onChanged: () => profileCubit.loadProfile(),
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(constants.scaffoldBodyPadding),
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
