import 'package:flutter/material.dart';
import 'package:helperr/features/edit_phone_numbers/view/phone_numbers_widget.dart';

import '../../data_layer/model/worker.dart';
import 'package:helperr/data_layer/data_provider/helperr_server.dart' as server;

class EditProfilePage extends StatefulWidget {
  EditProfilePage({
    Key key,
    @required this.onSave,
    @required this.worker,
  }) : super(key: key);

  final VoidCallback onSave;
  final Worker worker;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name;
  String _about;
  String _city;
  String _cz;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

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

    final phoneNumbersList = PhoneNumbers(numbers: widget.worker.phone);

    final backButton = IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      splashRadius: 24.0,
      onPressed: () => Navigator.pop(context),
    );

    final submitButton = IconButton(
      icon: const Icon(Icons.check_rounded),
      splashRadius: 24.0,
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          final editedWorker = widget.worker.copyWith(
            name: _name,
            about: _about,
            city: _city,
            cz: _cz,
          );
          // TODO: start from here
          await server.updateWorker(editedWorker);

          widget.onSave();
          Navigator.pop(context);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: backButton,
        title: const Text('Изменить профиль'),
        actions: [
          submitButton,
        ],
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
              cityInput,
              citizenshipInput,
              phoneNumbersList,
            ],
          ),
        ),
      ),
    );
  }
}
