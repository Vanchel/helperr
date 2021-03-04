import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chip_input_view.dart';
import '../../cubit/edit_list_cubit.dart';

class ChipInput extends StatelessWidget {
  const ChipInput({
    Key key,
    this.initialValue = const [],
    this.onChanged,
    this.labelText,
    this.hintText,
  }) : super(key: key);

  final List<String> initialValue;
  final Function(List<String> newValue) onChanged;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditListCubit(initialValue),
      child: ChipInputView(
        onChanged: onChanged,
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
