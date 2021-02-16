import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'education_view.dart';
import '../../cubit/edit_list_cubit.dart';
import '../../../../data_layer/model/worker.dart';

class EducationList extends StatelessWidget {
  const EducationList({Key key, this.initialValue = const [], this.onChanged})
      : super(key: key);

  final List<Education> initialValue;
  final void Function(List<Education> newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditListCubit(initialValue),
      child: EducationView(onChanged: onChanged),
    );
  }
}
