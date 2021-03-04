import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/edit_list_cubit.dart';

class PointsInputView extends StatefulWidget {
  const PointsInputView({
    Key key,
    @required this.onChanged,
    this.labelText,
    this.hintText,
  }) : super(key: key);

  final Function(List<String>) onChanged;
  final String labelText;
  final String hintText;

  @override
  _PointsInputViewState createState() => _PointsInputViewState();
}

class _PointsInputViewState extends State<PointsInputView> {
  final controller = TextEditingController();

  Widget _buildPointView(BuildContext context, String text, int index) {
    return Card(
      child: ListTile(
        title: Text(text),
        trailing: IconButton(
          icon: const Icon(Icons.remove_rounded),
          splashRadius: 24.0,
          onPressed: () =>
              context.read<EditListCubit<String>>().deleteValue(index),
        ),
      ),
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

    final _pointsList = BlocBuilder<EditListCubit<String>, List<String>>(
      builder: (context, state) {
        if (widget.onChanged != null) {
          widget.onChanged(state);
        }

        return Column(
          children: List.generate(state.length, (index) {
            return _buildPointView(context, state[index], index);
          }).toList(),
        );
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_inputField, _pointsList],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
