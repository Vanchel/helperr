import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_sex_view.dart';
import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/gender.dart';

class EditSex extends StatelessWidget {
  const EditSex({Key key, this.initialValue = Gender.unknown, this.onChanged})
      : super(key: key);

  final Gender initialValue;
  final Function(Gender) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSingleValueCubit<Gender>(initialValue),
      child: SexRadioGroup(onChanged: onChanged),
    );
  }
}
