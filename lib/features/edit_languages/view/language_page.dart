import 'package:flutter/material.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:helperr/features/edit_language_proficiency/view/edit_language_proficiency_widget.dart';

class EditLanguagePage extends StatefulWidget {
  EditLanguagePage({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.language,
  }) : super(key: key);

  final Function(Language) onSave;
  final bool isEditing;
  final Language language;

  @override
  _EditLanguagePageState createState() => _EditLanguagePageState();
}

class _EditLanguagePageState extends State<EditLanguagePage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _language;
  LanguageProficiency _proficiency;

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

          final editedLanguage = Language(
            language: _language,
            grade: _proficiency,
          );
          widget.onSave(editedLanguage);

          Navigator.pop(context);
        }
      },
    );

    final languageInput = TextFormField(
      initialValue: widget.isEditing ? widget.language.language : '',
      autofocus: !widget.isEditing,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Язык',
        hintText: 'Укажите язык',
      ),
      onSaved: (newValue) => _language = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return 'Поле не дожно быть пустым.';
        }
        return null;
      },
    );

    final proficiencyInput = EditLanguageProficiency(
      initialValue:
          widget.isEditing ? widget.language.grade : LanguageProficiency.a1,
      onChanged: (value) => _proficiency = value,
    );

    final commonPrompt = Container(
      margin: const EdgeInsets.only(top: 4.0),
      child: Text(
        'Если у Вас есть навык владения каким-либо иностранным языком, вы '
        'можете указать это в своем профиле. Так у Вас появится возможность '
        'прикрепить эту информацию к одному из своих резюме, если в этом '
        'возникнет необходимость.',
        style: themeData.textTheme.caption,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: backButton,
        title: Text(
          widget.isEditing
              ? 'Изменить владение языком'
              : 'Добавить владение языком',
        ),
        actions: [saveButton],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              languageInput,
              proficiencyInput,
              commonPrompt,
            ],
          ),
        ),
      ),
    );
  }
}
