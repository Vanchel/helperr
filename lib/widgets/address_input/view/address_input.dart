import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'address_input_view.dart';
import '../cubit/address_input_cubit.dart';
import '../../../data_layer/model/address.dart';

class AddressInput extends StatelessWidget {
  const AddressInput({
    Key key,
    @required this.initialValue,
    @required this.onUpdated,
    this.labelText,
    this.hintText,
    this.helperText,
  }) : super(key: key);

  final Address initialValue;
  final void Function(Address) onUpdated;

  final String labelText;
  final String hintText;
  final String helperText;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddressInputCubit(initialValue: initialValue ?? Address.empty),
      child: AddressInputView(
        initialValue: initialValue.name,
        onUpdated: onUpdated,
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
      ),
    );
  }
}
