import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_phone_numbers/cubit/phone_numbers_cubit.dart';
import 'package:helperr/features/edit_phone_numbers/view/phone_numbers_view.dart';

class PhoneNumbers extends StatelessWidget {
  const PhoneNumbers({Key key, this.numbers = const []}) : super(key: key);

  final List<String> numbers;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneNumbersCubit(numbers),
      child: PhoneNumbersView(),
    );
  }
}
