import 'package:flutter/material.dart';

class EditPhoneNumberPage extends StatefulWidget {
  EditPhoneNumberPage({Key key, @required this.onSave}) : super(key: key);

  final Function(String) onSave;

  @override
  _EditPhoneNumberPageState createState() => _EditPhoneNumberPageState();
}

class _EditPhoneNumberPageState extends State<EditPhoneNumberPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _phone;

  bool _isValidPhoneNumber(String str) {
    String pattern = r'^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(str);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          splashRadius: 24.0,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Добавить номер телефона'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_rounded),
            splashRadius: 24.0,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                widget.onSave(_phone);
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Номер телефона',
                  hintText: 'Добавьте номер телефона',
                ),
                onSaved: (newValue) => _phone = newValue,
                validator: (value) {
                  if (!_isValidPhoneNumber(value)) {
                    return 'Укажите корректный номер телефона';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'Вы можете указать несколько контанктных номеров телефона,'
                  ' с помощью которых работодатель сможет связаться с Вами.',
                  style: themeData.textTheme.caption,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
