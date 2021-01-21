import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:helperr/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:helperr/features/profile/cubit/profile_cubit.dart'
    as profileCubit;

class EditProfileView extends StatelessWidget {
  Widget _buildWorkerEdit(BuildContext context, Worker worker) {
    final themeData = Theme.of(context);

    final nameController = TextEditingController(text: worker.name);
    final aboutController = TextEditingController(text: worker.about);
    final cityController = TextEditingController(text: worker.city);
    final citizenshipController = TextEditingController(text: worker.cz);

    final nameInput = TextFormField(
      controller: nameController,
      decoration: const InputDecoration(
        labelText: 'Имя',
        hintText: 'Полное имя',
      ),
      validator: (value) => value.isEmpty ? 'Имя должно быть указано' : null,
    );

    final aboutInput = TextFormField(
      controller: aboutController,
      maxLength: 255,
      minLines: 2,
      maxLines: 4,
      decoration: const InputDecoration(
        labelText: 'О себе',
        hintText: 'Расскажите немного о себе...',
      ),
    );

    // final birthdayInput = TextFormField(
    //   onTap: () {
    //     FocusScope.of(context).requestFocus(FocusNode());
    //     final today = DateTime.now();
    //     showDatePicker(
    //       context: context,
    //       initialDate: today,
    //       firstDate: DateTime(1900),
    //       lastDate: today,
    //       locale: const Locale('ru'),
    //       fieldLabelText: 'Дата рождения',
    //       initialEntryMode: DatePickerEntryMode.input,
    //       initialDatePickerMode: DatePickerMode.year,
    //     );
    //   },
    // );

    final birthdayInput = InputDatePickerFormField(
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      fieldLabelText: 'Дата рождения',
      fieldHintText: 'дд.мм.гггг',
    );

    final cityInput = TextFormField(
      controller: cityController,
      decoration: const InputDecoration(
        labelText: 'Город',
        hintText: 'Город проживания',
      ),
    );

    final citizenshipInput = TextFormField(
      controller: citizenshipController,
      decoration: const InputDecoration(
        labelText: 'Страна',
        hintText: 'Страна проживания',
      ),
    );

    final phoneNumbersHeader = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Номера телефона', style: themeData.textTheme.subtitle1),
        OutlinedButton(
          child: const Text('Добавить'),
          onPressed: () {},
        ),
      ],
    );

    final phoneNumbersList = ListView.builder(
      itemCount: worker.phone.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(worker.phone[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit_rounded),
                  // open phone adding screen here
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.delete_rounded),
                  // rebuild too
                  onPressed: () => {}, //worker.phone.removeAt(index),
                ),
              ],
            ),
          ),
        );
      },
    );

    // ListView.builder(
    //   //itemCount: worker.phone.length,
    //   shrinkWrap: true,
    //   physics: const NeverScrollableScrollPhysics(),
    //   itemBuilder: (context, index) {
    //     return ListTile(
    //       title: Text(worker.phone[index]),
    //       trailing: Row(
    //         children: [
    //           IconButton(
    //             icon: Icon(Icons.edit_rounded),
    //             // open phone adding screen here
    //             onPressed: () {},
    //           ),
    //           IconButton(
    //               icon: Icon(Icons.delete_rounded),
    //               // rebuild too
    //               onPressed: () => {} //worker.phone.removeAt(index),
    //               ),
    //         ],
    //       ),
    //     );
    //   },
    // ),

    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is ProfileFailedSaving) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Не удалось сохранить профиль')));
        } else if (state is ProfileSuccessSaving) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Профиль успешно сохранен')));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Профиль'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            splashRadius: 24.0,
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.check_rounded),
              splashRadius: 24.0,
              onPressed: () {
                final editedWorker = worker.copyWith(
                  name: nameController.text,
                  about: aboutController.text,
                  city: cityController.text,
                  cz: citizenshipController.text,
                );
                context.read<EditProfileCubit>().saveProfile(editedWorker);
              },
            ),
          ],
        ),
        body: Form(
          key: GlobalKey<FormState>(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nameInput,
                aboutInput,
                birthdayInput,
                cityInput,
                citizenshipInput,
                phoneNumbersHeader,
                phoneNumbersList,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final onErr = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Произошла ошибка'),
        TextButton(
          child: const Text('Повторить попытку'),
          onPressed: () => context.read<EditProfileCubit>().loadProfile(),
        ),
      ],
    );

    return BlocBuilder<EditProfileCubit, EditProfileState>(
      // govnokod peredelat'
      buildWhen: (previous, current) {
        return !(current is ProfileFailedSaving ||
            current is ProfileSuccessSaving);
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Material(child: Center(child: CircularProgressIndicator()));
        } else if (state is ProfileLoaded) {
          // *** for testing purposes
          final worker = state.worker..phone.add('+79996761337');
          // ***

          return _buildWorkerEdit(context, worker);
        } else if (state is ProfileFailedLoading) {
          return Material(child: Center(child: onErr));
        } else {
          return Container(
              child: Center(child: Text('Это никто не должен был увидеть')));
        }
      },
    );
  }
}
