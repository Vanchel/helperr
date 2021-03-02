import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/models.dart';
import 'package:helperr/features/profile/employer/view/employer_profile_page.dart';
import 'package:helperr/features/profile/worker/view/worker_profile_page.dart';

import '../../data_layer/repository/authentication_repository.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = RepositoryProvider.of<AuthenticationRepository>(context).user;

    if (user.userType == UserType.employee) {
      return WorkerProfilePage(user.id);
    } else if (user.userType == UserType.employer) {
      return EmployerProfilePage(user.id);
    } else {
      return Container();
    }
  }
}
