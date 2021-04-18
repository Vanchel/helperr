import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/address_input_cubit.dart';
import '../../../constants.dart' as c;
import '../../../data_layer/model/address.dart';

class AddressInputView extends StatelessWidget {
  AddressInputView({
    Key key,
    @required this.initialValue,
    @required this.onUpdated,
    this.labelText,
    this.hintText,
    this.helperText,
  }) : super(key: key);

  final String initialValue;
  final void Function(Address address) onUpdated;

  final String labelText;
  final String hintText;
  final String helperText;

  @override
  Widget build(BuildContext context) {
    const textInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(c.borderRadius)),
    );

    return TextFormField(
      initialValue: initialValue ?? '',
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText ?? '',
        hintText: hintText ?? '',
        helperText: helperText ?? '',
        border: textInputBorder,
      ),
      onSaved: (newValue) => onUpdated(context.read<AddressInputCubit>().state),
      onChanged: (value) =>
          context.read<AddressInputCubit>().updateAddress(value),
      validator: (value) {
        if (value.isNotEmpty &&
            context.read<AddressInputCubit>().state == Address.empty) {
          return 'Введите корректное местоположение';
        }
        return null;
      },
    );
  }
}
