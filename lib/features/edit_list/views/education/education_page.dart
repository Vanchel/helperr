import 'package:flutter/material.dart';

import '../../../edit_single_value/views/education_type/edit_education_type.dart';
import '../../../../widgets/date_input.dart';
import '../../../../data_layer/model/models.dart';
import '../../../../constants.dart' as constants;

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

    final professionInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.isEditing ? widget.education.profession : '',
        autofocus: !widget.isEditing,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Специальность',
          hintText: 'Укажите специальность',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _profession = newValue,
        validator: (value) {
          if (value.isEmpty) {
            return 'Поле не дожно быть пустым.';
          }
          return null;
        },
      ),
    );

    final universityInput = Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        initialValue: widget.isEditing ? widget.education.university : '',
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Учебное заведение',
          hintText: 'Укажите учебное заведение',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _university = newValue,
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
      child: EditEducationType(
        initialValue:
            widget.isEditing ? widget.education.type : EducationType.course,
        onChanged: (value) => _type = value,
      ),
    );

    final startDateInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: DateInput(
        initialValue: widget.isEditing ? widget.education.startYear : null,
        labelText: 'Дата начала обучения',
        onValidate: (newValue) => _startDate = newValue,
      ),
    );

    final endDateInput = Container(
      child: DateInput(
        initialValue: widget.isEditing ? widget.education.endYear : null,
        labelText: 'Дата окончания обучения',
        onValidate: (newValue) => _endDate = newValue,
      ),
    );

    final divider = const Divider();

    final commonPrompt = Container(
      child: Text(
        'Укажите данные об имеющемся у Вас образовании. Эти сведения могут '
        'оказаться полезными для работодателя в зависимости от искомой '
        'должности.',
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
          padding:
              const EdgeInsets.all(constants.DEFAULT_SCAFFOLD_BODY_PADDING),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              professionInput,
              universityInput,
              typeInput,
              startDateInput,
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
