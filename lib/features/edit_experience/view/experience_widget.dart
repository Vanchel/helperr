import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:helperr/features/edit_experience/cubit/experience_cubit.dart';
import 'package:helperr/features/edit_experience/view/experience_view.dart';

class ExperienceList extends StatelessWidget {
  const ExperienceList({Key key, this.initialValue = const [], this.onChanged})
      : super(key: key);

  final List<Exp> initialValue;
  final Function(List<Exp> newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExperienceCubit(initialValue),
      child: ExperienceView(onChanged: onChanged),
    );
  }
}
