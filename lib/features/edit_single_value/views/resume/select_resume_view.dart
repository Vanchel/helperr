import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/resume.dart';

class ResumesDropdownButton extends StatelessWidget {
  const ResumesDropdownButton({
    Key key,
    this.resumes,
    @required this.onChanged,
  }) : super(key: key);

  final List<Resume> resumes;
  final Function(Resume) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSingleValueCubit<Resume>, Resume>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        final dropdownValue = state;

        return DropdownButtonFormField<Resume>(
          decoration: InputDecoration(
            labelText: 'Резюме',
            hintText: 'Выберите резюме',
            helperText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
          value: dropdownValue,
          isExpanded: true,
          onChanged: (value) =>
              context.read<EditSingleValueCubit<Resume>>().changeValue(value),
          validator: (value) => (value == null) ? 'Резюме не выбрано' : null,
          items: List.generate(
            resumes.length,
            (index) {
              return DropdownMenuItem<Resume>(
                value: resumes[index],
                child: Text(resumes[index].vacancyName),
              );
            },
          ),
        );
      },
    );
  }
}
