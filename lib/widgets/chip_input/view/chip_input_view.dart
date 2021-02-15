import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/chip_input_cubit.dart';

class ChipInputView extends StatelessWidget {
  const ChipInputView({
    Key key,
    @required this.onChanged,
    this.labelText,
    this.hintText,
  }) : super(key: key);

  final Function(List<String>) onChanged;
  final String labelText;
  final String hintText;

  Widget _buildInputChip(BuildContext context, String text) {
    return InputChip(
      label: Text(text),
      onDeleted: () => context.read<ChipInputCubit>().removeChip(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)));

    String _text;

    final _addButton = Container(
      margin: const EdgeInsets.only(right: 6.0),
      child: IconButton(
        icon: Icon(Icons.add_rounded),
        splashRadius: 24.0,
        onPressed: () {
          if (_text.isNotEmpty) {
            context.read<ChipInputCubit>().addChip(_text);
          }
        },
      ),
    );

    final _inputField = Container(
      //margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value) => _text = value,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: '',
          border: textInputBorder,
          suffixIcon: _addButton,
        ),
      ),
    );

    final _chipsList = BlocBuilder<ChipInputCubit, List<String>>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        return Wrap(
          spacing: 4.0,
          children: List.generate(
            state.length,
            (index) => _buildInputChip(context, state[index]),
          ).toList(),
        );
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _inputField,
        _chipsList,
      ],
    );
  }
}
