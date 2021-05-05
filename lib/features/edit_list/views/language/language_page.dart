import 'package:flutter/material.dart';
import 'package:helperr/widgets/custom_back_button.dart';

import '../../../edit_single_value/views/language_proficiency/edit_language_proficiency.dart';
import '../../../../data_layer/model/models.dart';
import '../../../../constants.dart' as c;

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

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(c.borderRadius)));

    final saveButton = IconButton(
      icon: const Icon(Icons.check_rounded),
      splashRadius: c.iconButtonSplashRadius,
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
        helperText: '',
        border: textInputBorder,
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
      child: Text(
        'Если у Вас есть навык владения каким-либо иностранным языком, вы '
        'можете указать это в своем профиле. Эти данные могут оказаться '
        'полезными в зависимости от рассматриваемой вакансии.',
        style: themeData.textTheme.caption,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
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
          padding: const EdgeInsets.all(c.scaffoldBodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              languageInput,
              const SizedBox(height: c.defaultMargin),
              proficiencyInput,
              const Divider(),
              commonPrompt,
            ],
          ),
        ),
      ),
    );
  }
}
