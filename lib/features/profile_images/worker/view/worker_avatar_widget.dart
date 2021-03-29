import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'worker_avatar_view.dart';
import '../cubit/worker_image_cubit.dart';
import '../../../../data_layer/model/worker.dart';

class WorkerAvatar extends StatelessWidget {
  const WorkerAvatar({
    Key key,
    this.worker,
    this.onChanged,
  }) : super(key: key);

  final Worker worker;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkerImageCubit(),
      child: WorkerAvatarView(
        worker: worker,
        onChanged: onChanged,
      ),
    );
  }
}
