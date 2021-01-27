import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:helperr/features/edit_sex/cubit/edit_sex_cubit.dart';

class SexRadioGroup extends StatelessWidget {
  const SexRadioGroup({Key key, @required this.onChanged}) : super(key: key);

  final Function(Gender) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSexCubit, Gender>(builder: (context, state) {
      if (onChanged != null) {
        onChanged(state);
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Пол'),
          RadioListTile(
            title: const Text('Мужчина'),
            value: Gender.male,
            groupValue: state,
            onChanged: (value) => context.read<EditSexCubit>().changeSex(value),
          ),
          RadioListTile(
            title: const Text('Женщина'),
            value: Gender.female,
            groupValue: state,
            onChanged: (value) => context.read<EditSexCubit>().changeSex(value),
          ),
          RadioListTile(
            title: const Text('Не важно'),
            value: Gender.unknown,
            groupValue: state,
            onChanged: (value) => context.read<EditSexCubit>().changeSex(value),
          ),
        ],
      );
    });
  }
}
