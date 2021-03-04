import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/edit_list_cubit.dart';

class ChipInputView extends StatefulWidget {
  const ChipInputView({
    Key key,
    @required this.onChanged,
    this.labelText,
    this.hintText,
  }) : super(key: key);

  final Function(List<String>) onChanged;
  final String labelText;
  final String hintText;

  @override
  _ChipInputViewState createState() => _ChipInputViewState();
}

class _ChipInputViewState extends State<ChipInputView> {
  final controller = TextEditingController();

  Widget _buildInputChip(BuildContext context, String text, int index) {
    return InputChip(
      label: Text(text),
      onDeleted: () => context.read<EditListCubit<String>>().deleteValue(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    const textInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
    );

    final _addButton = Container(
      margin: const EdgeInsets.only(right: 6.0),
      child: IconButton(
        icon: Icon(Icons.add_rounded),
        splashRadius: 24.0,
        onPressed: () {
          if (controller.text.isNotEmpty) {
            context.read<EditListCubit<String>>().addValue(controller.text);
            controller.text = '';
          }
        },
      ),
    );

    final _inputField = Container(
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          helperText: '',
          border: textInputBorder,
          suffixIcon: _addButton,
        ),
      ),
    );

    final _chipsList = BlocBuilder<EditListCubit<String>, List<String>>(
      builder: (context, state) {
        if (widget.onChanged != null) {
          widget.onChanged(state);
        }

        return Wrap(
          spacing: 4.0,
          children: List.generate(state.length, (index) {
            return _buildInputChip(context, state[index], index);
          }).toList(),
        );
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_inputField, _chipsList],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
