import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/gender.dart';

class SexRadioGroup extends StatelessWidget {
  const SexRadioGroup({Key key, @required this.onChanged}) : super(key: key);

  final Function(Gender) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSingleValueCubit<Gender>, Gender>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        final onChangedValue = (Gender value) {
          context.read<EditSingleValueCubit<Gender>>().changeValue(value);
        };

        return Card(
          margin: const EdgeInsets.all(0.0),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile(
                title: const Text('Мужчина'),
                value: Gender.male,
                groupValue: state,
                onChanged: onChangedValue,
              ),
              RadioListTile(
                title: const Text('Женщина'),
                value: Gender.female,
                groupValue: state,
                onChanged: onChangedValue,
              ),
              RadioListTile(
                title: const Text('Не важно'),
                value: Gender.unknown,
                groupValue: state,
                onChanged: onChangedValue,
              ),
            ],
          ),
        );
      },
    );
  }
}
