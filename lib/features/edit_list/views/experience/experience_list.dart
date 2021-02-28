import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'experience_view.dart';
import '../../cubit/edit_list_cubit.dart';
import '../../../../data_layer/model/experience.dart';

class ExperienceList extends StatelessWidget {
  const ExperienceList({Key key, this.initialValue = const [], this.onChanged})
      : super(key: key);

  final List<Exp> initialValue;
  final void Function(List<Exp> newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditListCubit(initialValue),
      child: ExperienceView(onChanged: onChanged),
    );
  }
}
