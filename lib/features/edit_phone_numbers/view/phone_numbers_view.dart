import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_phone_numbers/cubit/phone_numbers_cubit.dart';
import 'package:helperr/features/edit_phone_numbers/view/edit_phone_number_page.dart';

class PhoneNumbersView extends StatelessWidget {
  PhoneNumbersView({Key key, @required this.onChanged}) : super(key: key);

  final Function(List<String>) onChanged;

  Widget _buildNumberCard(BuildContext context, String number) {
    return Card(
      child: ListTile(
        title: Text(number),
        trailing: IconButton(
          icon: const Icon(Icons.delete_rounded),
          splashRadius: 24.0,
          onPressed: () {
            context.read<PhoneNumbersCubit>().deleteNumber(number);
            // use as a separate widget
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(
                  'Номер телефона удален',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                action: SnackBarAction(
                  label: 'отменить',
                  onPressed: () =>
                      context.read<PhoneNumbersCubit>().addNumber(number),
                ),
              ));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final phoneNumberCubit = BlocProvider.of<PhoneNumbersCubit>(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Номера телефона', style: themeData.textTheme.subtitle1),
            OutlinedButton(
              child: const Text('Добавить'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return EditPhoneNumberPage(
                      onSave: (phoneNumber) =>
                          phoneNumberCubit.addNumber(phoneNumber),
                    );
                  },
                ));
              },
            ),
          ],
        ),
        BlocBuilder<PhoneNumbersCubit, List<String>>(
          builder: (context, state) {
            if (onChanged != null) {
              onChanged(state);
            }

            return Column(
              children: [
                for (final number in state) _buildNumberCard(context, number)
              ],
            );
          },
        ),
      ],
    );
  }
}
