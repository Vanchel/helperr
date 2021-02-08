import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_phone_numbers/cubit/phone_numbers_cubit.dart';
import 'package:helperr/features/edit_phone_numbers/view/edit_phone_number_page.dart';
import 'package:helperr/widgets/list_action_header.dart';

class PhoneNumbersView extends StatelessWidget {
  const PhoneNumbersView({Key key, @required this.onChanged}) : super(key: key);

  final Function(List<String>) onChanged;

  Widget _buildNumberCard(BuildContext context, String number, int index) {
    return Card(
      child: ListTile(
        title: Text(number),
        trailing: IconButton(
          icon: const Icon(Icons.delete_rounded),
          splashRadius: 24.0,
          onPressed: () {
            context.read<PhoneNumbersCubit>().deleteNumber(index);
            // use as a separate widget
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(
                  'Элемент удален',
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
    final phoneNumberCubit = BlocProvider.of<PhoneNumbersCubit>(context);

    final onAdd = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditPhoneNumberPage(
            onSave: (phoneNumber) => phoneNumberCubit.addNumber(phoneNumber),
          );
        },
      ));
    };

    return Column(
      children: [
        ListActionHeader('Номера телефона',
            actionLabel: 'Добавить', action: onAdd),
        BlocBuilder<PhoneNumbersCubit, List<String>>(
          builder: (context, state) {
            if (onChanged != null) {
              onChanged(state);
            }

            return Column(
              children: List.generate(
                state.length,
                (index) => _buildNumberCard(context, state[index], index),
              ).toList(),
            );
          },
        ),
      ],
    );
  }
}
