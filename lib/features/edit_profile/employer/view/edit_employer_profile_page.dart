import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/employer.dart';

import '../cubit/edit_profile_cubit.dart';
import 'edit_employer_profile_view.dart';

class EditEmployerProfilePage extends StatelessWidget {
  EditEmployerProfilePage({
    Key key,
    @required this.onSave,
    @required this.employer,
  }) : super(key: key);

  final VoidCallback onSave;
  final Employer employer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: EditEmployerProfileView(employer: employer, onSave: onSave),
    );
  }
}
