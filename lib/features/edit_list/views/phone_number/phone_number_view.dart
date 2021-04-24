import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'phone_number_page.dart';
import '../../cubit/edit_list_cubit.dart';
import '../../../../widgets/list_action_header.dart';
import '../../../../constants.dart' as c;

class PhoneNumberView extends StatelessWidget {
  const PhoneNumberView({Key key, @required this.onChanged}) : super(key: key);

  final void Function(List<String>) onChanged;

  Widget _buildItemView(BuildContext context, String phoneNumber, int index) {
    final onDelete = () {
      context.read<EditListCubit<String>>().deleteValue(index);
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
            onPressed: () {
              context.read<EditListCubit<String>>().addValue(phoneNumber);
            },
          ),
        ));
    };

    return Card(
      margin: const EdgeInsets.symmetric(vertical: c.defaultMargin),
      child: ListTile(
        title: Text(phoneNumber),
        trailing: IconButton(
          icon: const Icon(Icons.delete_rounded),
          splashRadius: c.iconButtonSplashRadius,
          onPressed: onDelete,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<EditListCubit<String>>(context);

    final onAdd = () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditPhoneNumberPage(
            onSave: (phoneNumber) {
              cubit.addValue(phoneNumber);
            },
          );
        },
      ));
    };

    return Column(
      children: [
        ListAddHeader('Номера телефона', action: onAdd),
        BlocBuilder<EditListCubit<String>, List<String>>(
          builder: (context, state) {
            if (onChanged != null) {
              onChanged(state);
            }

            return Column(
              children: List.generate(state.length, (index) {
                return _buildItemView(context, state[index], index);
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
