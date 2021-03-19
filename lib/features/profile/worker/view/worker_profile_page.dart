import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/profile_cubit.dart';
import 'worker_profile_view.dart';

class WorkerProfilePage extends StatelessWidget {
  const WorkerProfilePage(int userId, {Key key})
      : assert(userId != null),
        this.userId = userId,
        super(key: key);

  final int userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(id: userId)..loadProfile(),
      child: WorkerProfileView(),
    );
  }
}
