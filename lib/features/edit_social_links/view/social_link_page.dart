import 'package:flutter/material.dart';

class EditSocialLinkPage extends StatefulWidget {
  EditSocialLinkPage({Key key, @required this.onSave}) : super(key: key);

  final Function(String) onSave;

  @override
  _EditSocialLinkState createState() => _EditSocialLinkState();
}

class _EditSocialLinkState extends State<EditSocialLinkPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _socialLink;

  bool _isValidLink(String str) {
    String pattern =
        r'[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(str);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final backButton = IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      splashRadius: 24.0,
      onPressed: () => Navigator.pop(context),
    );

    final saveButton = IconButton(
      icon: const Icon(Icons.check_rounded),
      splashRadius: 24.0,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          widget.onSave(_socialLink);
          Navigator.pop(context);
        }
      },
    );

    final linkInput = TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.url,
      decoration: const InputDecoration(
        labelText: 'URL',
        hintText: 'https://example.com/profile_name',
      ),
      onSaved: (newValue) => _socialLink = newValue,
      validator: (value) {
        if (!_isValidLink(value)) {
          return 'Укажите корректный URL.';
        }
        return null;
      },
    );

    final commonPrompt = Container(
      margin: const EdgeInsets.only(top: 4.0),
      child: Text(
        'Вы можете указать в профиле ссылки на аккаунты в различных '
        'социальных сетях, чтобы с Вами можно было связаться там.',
        style: themeData.textTheme.caption,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: backButton,
        title: const Text('Добавить ссылку на соц. сеть'),
        actions: [saveButton],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: [linkInput, commonPrompt]),
        ),
      ),
    );
  }
}
