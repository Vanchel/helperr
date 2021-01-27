import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:helperr/features/edit_sex/cubit/edit_sex_cubit.dart';
import 'package:helperr/features/edit_sex/view/edit_sex_view.dart';

class EditSex extends StatelessWidget {
  const EditSex({Key key, this.initialValue = Gender.unknown, this.onChanged})
      : super(key: key);

  final Gender initialValue;
  final Function(Gender) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSexCubit(initialValue),
      child: SexRadioGroup(onChanged: onChanged),
    );
  }
}
