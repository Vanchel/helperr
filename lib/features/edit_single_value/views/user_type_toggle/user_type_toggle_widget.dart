import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_type_toggle_view.dart';
import '../../cubit/edit_single_value_cubit.dart';
import '../../../../data_layer/model/user_type.dart';

class UserTypeToggle extends StatelessWidget {
  const UserTypeToggle({
    Key key,
    this.initialValue = UserType.employee,
    this.onChanged,
  }) : super(key: key);

  final UserType initialValue;
  final Function(UserType) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSingleValueCubit<UserType>(initialValue),
      child: UserTypeToggleView(onChanged: onChanged),
    );
  }
}
