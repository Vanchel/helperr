import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:helperr/features/edit_phone_numbers/view/phone_numbers_widget.dart';
import 'package:helperr/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:helperr/features/edit_sex/view/edit_sex_widget.dart';

import '../../../data_layer/model/worker.dart';

class EditProfileView extends StatefulWidget {
  EditProfileView({Key key, @required this.onSave, @required this.worker})
      : super(key: key);

  final VoidCallback onSave;
  final Worker worker;

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name;
  String _about;
  Gender _gender;
  String _city;
  String _cz;
  List<String> _phoneNumbers;

  @override
  Widget build(BuildContext context) {
    final nameInput = TextFormField(
      initialValue: widget.worker.name,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        labelText: 'Имя',
        hintText: 'Полное имя',
      ),
      validator: (value) => value.isEmpty ? 'Имя должно быть указано' : null,
      onSaved: (newValue) => _name = newValue,
    );

    final aboutInput = TextFormField(
      initialValue: widget.worker.about,
      keyboardType: TextInputType.multiline,
      maxLength: 255,
      minLines: 2,
      maxLines: 4,
      decoration: const InputDecoration(
        labelText: 'О себе',
        hintText: 'Расскажите немного о себе...',
      ),
      onSaved: (newValue) => _about = newValue,
    );

    // final birthdayInput = InputDatePickerFormField(
    //   firstDate: DateTime(1900),
    //   lastDate: DateTime.now(),
    //   fieldLabelText: 'Дата рождения',
    //   //fieldHintText: 'дд.мм.гггг',
    // );

    final genderInput = EditSex(
      initialValue: widget.worker.gender,
      onChanged: (value) => _gender = value,
    );

    final cityInput = TextFormField(
      initialValue: widget.worker.city,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Город',
        hintText: 'Город проживания',
      ),
      onSaved: (newValue) => _city = newValue,
    );

    final citizenshipInput = TextFormField(
      initialValue: widget.worker.cz,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Страна',
        hintText: 'Страна проживания',
      ),
      onSaved: (newValue) => _cz = newValue,
    );

    final phoneNumbersList = PhoneNumbers(
      initialValue: widget.worker.phone,
      onChanged: (newValue) => _phoneNumbers = newValue,
    );

    final backButton = IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      splashRadius: 24.0,
      onPressed: () => Navigator.pop(context),
    );

    final onSubmitPressed = () {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        final editedWorker = widget.worker.copyWith(
          name: _name,
          about: _about,
          gender: _gender,
          city: _city,
          cz: _cz,
          phone: _phoneNumbers,
        );
        context.read<EditProfileCubit>().saveProfile(editedWorker);
      }
    };

    final submitButton = BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        return IconButton(
          icon: const Icon(Icons.check_rounded),
          splashRadius: 24.0,
          onPressed: !(state is ProfileSaveInProgress) ? onSubmitPressed : null,
        );
      },
    );

    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is ProfileSaveFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.black54,
                content: Text('Не удалось обновить профиль'),
              ),
            );
        } else if (state is ProfileSaveSuccess) {
          widget.onSave();
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: backButton,
          title: const Text('Изменить профиль'),
          actions: [submitButton],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nameInput,
                aboutInput,
                //birthdayInput,
                genderInput,
                cityInput,
                citizenshipInput,
                phoneNumbersList,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
