import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';

import '../cubit/edit_profile_cubit.dart';
import 'edit_worker_profile_view.dart';

class EditWorkerProfilePage extends StatelessWidget {
  EditWorkerProfilePage({Key key, @required this.onSave, @required this.worker})
      : super(key: key);

  final VoidCallback onSave;
  final Worker worker;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: EditWorkerProfileView(worker: worker, onSave: onSave),
    );
  }
}
