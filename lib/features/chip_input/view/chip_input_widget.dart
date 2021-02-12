import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/chip_input/cubit/chip_input_cubit.dart';
import 'package:helperr/features/chip_input/view/chip_input_view.dart';

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
      create: (context) => ChipInputCubit(initialValue),
      child: ChipInputView(
        onChanged: onChanged,
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
