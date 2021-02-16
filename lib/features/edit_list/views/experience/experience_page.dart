import 'package:flutter/material.dart';

import '../../../edit_single_value/views/experience_type/edit_experience_type.dart';
import '../../../../widgets/date_input.dart';
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

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)));

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

    final positionInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.isEditing ? widget.experience.position : '',
        autofocus: !widget.isEditing,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Должность',
          hintText: 'Укажите должность',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _position = newValue,
        validator: (value) {
          if (value.isEmpty) {
            return 'Поле не дожно быть пустым.';
          }
          return null;
        },
      ),
    );

    final companyInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.isEditing ? widget.experience.company : '',
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Компания',
          hintText: 'Укажите название компании',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _company = newValue,
        validator: (value) {
          if (value.isEmpty) {
            return 'Поле не дожно быть пустым.';
          }
          return null;
        },
      ),
    );

    final typeInput = Container(
      margin: const EdgeInsets.only(bottom: 38.0),
      child: EditExperienceType(
        initialValue: widget.isEditing
            ? widget.experience.type
            : ExperienceType.internship,
        onChanged: (value) => _type = value,
      ),
    );

    final startDateInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: DateInput(
        initialValue: widget.isEditing ? widget.experience.startYear : null,
        labelText: 'Дата начала работы',
        onValidate: (newValue) => _startDate = newValue,
      ),
    );

    final endDateInput = Container(
      child: DateInput(
        initialValue: widget.isEditing ? widget.experience.endYear : null,
        labelText: 'Дата окончания работы',
        onValidate: (newValue) => _endDate = newValue,
      ),
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

    final divider = const Divider();

    final commonPrompt = Container(
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              positionInput,
              companyInput,
              typeInput,
              startDateInput,
              //untilNowSwitch,
              endDateInput,
              divider,
              commonPrompt,
            ],
          ),
        ),
      ),
    );
  }
}
