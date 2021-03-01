import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_single_value/cubit/edit_single_value_cubit.dart';

import '../../../../data_layer/model/user_type.dart';

class UserTypeToggleView extends StatelessWidget {
  const UserTypeToggleView({Key key, @required this.onChanged})
      : super(key: key);

  final Function(UserType) onChanged;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<EditSingleValueCubit<UserType>, UserType>(
      builder: (context, state) {
        if (onChanged != null) {
          onChanged(state);
        }

        final onChangedValue = (UserType value) =>
            context.read<EditSingleValueCubit<UserType>>().changeValue(value);

        final isSelected = <bool>[
          state == UserType.employee,
          state == UserType.employer,
        ];

        return ToggleButtons(
          isSelected: isSelected,
          selectedBorderColor: themeData.primaryColor,
          onPressed: (index) {
            if (index == 0) {
              onChangedValue(UserType.employee);
            } else if (index == 1) {
              onChangedValue(UserType.employer);
            }
          },
          constraints: const BoxConstraints(minHeight: 36.0, minWidth: 36.0),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Соискатель'.toUpperCase()),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Работодатель'.toUpperCase()),
            ),
          ],
        );
      },
    );
  }
}
