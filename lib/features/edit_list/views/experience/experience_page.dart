import 'package:flutter/material.dart';

import '../../../edit_single_value/views/experience_type/edit_experience_type.dart';
import '../../../../data_layer/model/worker.dart';

class EditExperiencePage extends StatefulWidget {
  EditExperiencePage({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.experience,
  }) : super(key: key);

  final Function(Exp) onSave;
  final bool isEditing;
  final Exp experience;

  @override
  _EditExperiencePageState createState() => _EditExperiencePageState();
}

class _EditExperiencePageState extends State<EditExperiencePage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _position;
  String _company;
  ExperienceType _type;
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

          final editedExperience = Exp(
            position: _position,
            company: _company,
            type: _type,
            startYear: _startDate,
            endYear: _endDate,
          );
          widget.onSave(editedExperience);

          Navigator.pop(context);
        }
      },
    );

    final positionInput = TextFormField(
      initialValue: widget.isEditing ? widget.experience.position : '',
      autofocus: !widget.isEditing,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Должность',
        hintText: 'Укажите должность',
      ),
      onSaved: (newValue) => _position = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return 'Поле не дожно быть пустым.';
        }
        return null;
      },
    );

    final companyInput = TextFormField(
      initialValue: widget.isEditing ? widget.experience.company : '',
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Компания',
        hintText: 'Укажите название компании',
      ),
      onSaved: (newValue) => _company = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return 'Поле не дожно быть пустым.';
        }
        return null;
      },
    );

    final typeInput = EditExperienceType(
      initialValue:
          widget.isEditing ? widget.experience.type : ExperienceType.internship,
      onChanged: (value) => _type = value,
    );

    final startDateInput = InputDatePickerFormField(
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: widget.isEditing ? widget.experience.startYear : null,
      fieldLabelText: 'Дата начала работы',
      fieldHintText: 'мм/дд/гггг',
      errorInvalidText: 'Указана дата вне допустимого диапазона.',
      errorFormatText: 'Неверный формат даты.',
      onDateSaved: (value) => _startDate = value,
    );

    final endDateInput = InputDatePickerFormField(
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: widget.isEditing ? widget.experience.endYear : null,
      fieldLabelText: 'Дата окончания работы',
      fieldHintText: 'мм/дд/гггг',
      errorInvalidText: 'Указана дата вне допустимого диапазона.',
      errorFormatText: 'Неверный формат даты.',
      onDateSaved: (value) => _endDate = value,
    );

    // final untilNowSwitch = Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Text('Работаю до сих пор', style: themeData.textTheme.subtitle1),
    //     Switch(
    //       value: true,
    //       onChanged: (value) {},
    //     ),
    //   ],
    // );

    final commonPrompt = Container(
      margin: const EdgeInsets.only(top: 4.0),
      child: Text(
        'Укажите данные об имеющемся у Вас опыте работы. Вы '
        'сможете прикрепить эти данные к любому своему резюме.',
        style: themeData.textTheme.caption,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: backButton,
        title: Text(
          widget.isEditing ? 'Изменить опыт работы' : 'Добавить опыт работы',
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
              positionInput,
              companyInput,
              typeInput,
              startDateInput,
              //untilNowSwitch,
              endDateInput,
              commonPrompt,
            ],
          ),
        ),
      ),
    );
  }
}
