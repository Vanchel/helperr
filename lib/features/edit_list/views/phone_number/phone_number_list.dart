import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'phone_number_view.dart';
import '../../cubit/edit_list_cubit.dart';

class PhoneNumberList extends StatelessWidget {
  const PhoneNumberList({Key key, this.initialValue = const [], this.onChanged})
      : super(key: key);

  final List<String> initialValue;
  final void Function(List<String> newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditListCubit(initialValue),
      child: PhoneNumberView(onChanged: onChanged),
    );
  }
}
