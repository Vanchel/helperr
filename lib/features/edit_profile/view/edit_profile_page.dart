import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:helperr/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:helperr/features/edit_profile/view/edit_profile_view.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key key, @required this.onSave, @required this.worker})
      : super(key: key);

  final VoidCallback onSave;
  final Worker worker;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: EditProfileView(worker: worker, onSave: onSave),
    );
  }
}
