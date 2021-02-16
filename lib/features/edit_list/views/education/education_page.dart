import 'package:flutter/material.dart';

import '../../../edit_single_value/views/education_type/edit_education_type.dart';
import '../../../../data_layer/model/models.dart';

class EditEducationPage extends StatefulWidget {
  EditEducationPage({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.education,
  }) : super(key: key);

  final Function(Education) onSave;
  final bool isEditing;
  final Education education;

  @override
  _EditEducationPageState createState() => _EditEducationPageState();
}

class _EditEducationPageState extends State<EditEducationPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _profession;
  String _university;
  EducationType _type;
  DateTime _startDate;
  DateTime _endDate;

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

          final editedEducation = Education(
            profession: _profession,
            university: _university,
            type: _type,
            startYear: _startDate,
            endYear: _endDate,
          );
          widget.onSave(editedEducation);

          Navigator.pop(context);
        }
      },
    );

    final professionInput = TextFormField(
      initialValue: widget.isEditing ? widget.education.profession : '',
      autofocus: !widget.isEditing,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Специальность',
        hintText: 'Укажите специальность',
      ),
      onSaved: (newValue) => _profession = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return 'Поле не дожно быть пустым.';
        }
        return null;
      },
    );

    final universityInput = TextFormField(
      initialValue: widget.isEditing ? widget.education.university : '',
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Учебное заведение',
        hintText: 'Укажите учебное заведение',
      ),
      onSaved: (newValue) => _university = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return 'Поле не дожно быть пустым.';
        }
        return null;
      },
    );

    final typeInput = EditEducationType(
      initialValue:
          widget.isEditing ? widget.education.type : EducationType.course,
      onChanged: (value) => _type = value,
    );

    final startDateInput = InputDatePickerFormField(
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: widget.isEditing ? widget.education.startYear : null,
      fieldLabelText: 'Дата начала обучения',
      fieldHintText: 'мм/дд/гггг',
      errorInvalidText: 'Указана дата вне допустимого диапазона.',
      errorFormatText: 'Неверный формат даты.',
      onDateSaved: (value) => _startDate = value,
    );

    final endDateInput = InputDatePickerFormField(
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 15),
      initialDate: widget.isEditing ? widget.education.endYear : null,
      fieldLabelText: 'Дата окончания обучения',
      fieldHintText: 'мм/дд/гггг',
      errorInvalidText: 'Указана дата вне допустимого диапазона.',
      errorFormatText: 'Неверный формат даты.',
      onDateSaved: (value) => _endDate = value,
    );

    final commonPrompt = Container(
      margin: const EdgeInsets.only(top: 4.0),
      child: Text(
        'Укажите данные об имеющемся у Вас образовании. Вы '
        'сможете прикрепить эти данные к любому своему резюме.',
        style: themeData.textTheme.caption,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: backButton,
        title: Text(
          widget.isEditing ? 'Изменить образование' : 'Добавить образование',
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
              professionInput,
              universityInput,
              typeInput,
              startDateInput,
              endDateInput,
              commonPrompt,
            ],
          ),
        ),
      ),
    );
  }
}
