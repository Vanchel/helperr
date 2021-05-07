import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/publication_age.dart';

class PublicationAgeDropdownButton extends StatelessWidget {
  const PublicationAgeDropdownButton({Key key, @required this.onChanged})
      : super(key: key);

  final Function(PublicationAge) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditSingleValueCubit<PublicationAge>, PublicationAge>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        final dropdownValue = state;

        return DropdownButtonFormField<PublicationAge>(
          decoration: InputDecoration(
            labelText: 'Выводить результаты',
            hintText: 'Выберите период публикации',
            helperText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
          value: dropdownValue,
          isExpanded: true,
          onChanged: (value) {
            context
                .read<EditSingleValueCubit<PublicationAge>>()
                .changeValue(value);
          },
          items: const [
            DropdownMenuItem<PublicationAge>(
              value: PublicationAge.allTime,
              child: Text('За все время'),
            ),
            DropdownMenuItem<PublicationAge>(
              value: PublicationAge.day,
              child: Text('За сутки'),
            ),
            DropdownMenuItem<PublicationAge>(
              value: PublicationAge.threeDays,
              child: Text('За три дня'),
            ),
            DropdownMenuItem<PublicationAge>(
              value: PublicationAge.week,
              child: Text('За неделю'),
            ),
            DropdownMenuItem<PublicationAge>(
              value: PublicationAge.twoWeeks,
              child: Text('За две недели'),
            ),
            DropdownMenuItem<PublicationAge>(
              value: PublicationAge.month,
              child: Text('За месяц'),
            ),
          ],
        );
      },
    );
  }
}
