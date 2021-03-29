import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'employer_avatar_view.dart';
import '../cubit/employer_image_cubit.dart';
import '../../../../data_layer/model/employer.dart';

class EmployerAvatar extends StatelessWidget {
  const EmployerAvatar({
    Key key,
    this.employer,
    this.onChanged,
  }) : super(key: key);

  final Employer employer;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployerImageCubit(),
      child: EmployerAvatarView(
        employer: employer,
        onChanged: onChanged,
      ),
    );
  }
}
