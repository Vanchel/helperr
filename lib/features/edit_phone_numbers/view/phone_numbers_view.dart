import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_phone_numbers/cubit/phone_numbers_cubit.dart';
import 'package:helperr/features/edit_phone_numbers/view/edit_phone_number_page.dart';

class PhoneNumbersView extends StatelessWidget {
  PhoneNumbersView({Key key}) : super(key: key);

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
            return ListView.builder(
              // bad practice in the context of performance, TODO: think about it
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // ***
              itemCount: state.length,
              itemBuilder: (context, index) {
                final number = state[index];
                return Card(
                  child: ListTile(
                    title: Text(number),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_rounded),
                      splashRadius: 24.0,
                      onPressed: () {
                        context.read<PhoneNumbersCubit>().deleteNumber(number);

                        // TODO: extract to a separate widget
                        // this also causes bug at the moment
                        // ScaffoldMessenger.of(context)
                        //   ..hideCurrentSnackBar()
                        //   ..showSnackBar(SnackBar(
                        //     content: Text(
                        //       'Номер телефона удален',
                        //       maxLines: 1,
                        //       overflow: TextOverflow.ellipsis,
                        //     ),
                        //     action: SnackBarAction(
                        //       label: 'отменить',
                        //       onPressed: () => context
                        //           .read<PhoneNumbersCubit>()
                        //           .addNumber(number),
                        //     ),
                        //   ));
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
