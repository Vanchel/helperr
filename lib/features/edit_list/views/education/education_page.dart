import 'package:flutter/material.dart';
import 'package:helperr/widgets/custom_back_button.dart';

import '../../../edit_single_value/views/education_type/edit_education_type.dart';
import '../../../../widgets/date_input.dart';
import '../../../../data_layer/model/models.dart';
import '../../../../constants.dart' as c;

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
        borderRadius: BorderRadius.all(Radius.circular(c.borderRadius)));

    final saveButton = IconButton(
      icon: const Icon(Icons.check_rounded),
      splashRadius: c.iconButtonSplashRadius,
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
    );

    final universityInput = TextFormField(
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
    );

    final typeInput = EditEducationType(
      initialValue:
          widget.isEditing ? widget.education.type : EducationType.course,
      onChanged: (value) => _type = value,
    );

    final startDateInput = DateInput(
      initialValue: widget.isEditing ? widget.education.startYear : null,
      labelText: 'Дата начала обучения',
      onValidate: (newValue) => _startDate = newValue,
      validator: (value) {
        return (value == null) ? 'Дата должна быть указана' : null;
      },
    );

    final endDateInput = DateInput(
      initialValue: widget.isEditing ? widget.education.endYear : null,
      labelText: 'Дата окончания обучения',
      onValidate: (newValue) => _endDate = newValue,
      validator: (value) {
        return (value == null) ? 'Дата должна быть указана' : null;
      },
    );

    final commonPrompt = Text(
      'Укажите данные об имеющемся у Вас образовании. Эти сведения могут '
      'оказаться полезными для работодателя в зависимости от искомой '
      'должности.',
      style: themeData.textTheme.caption,
    );

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(
          widget.isEditing ? 'Изменить образование' : 'Добавить образование',
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
              professionInput,
              const SizedBox(height: c.defaultMargin),
              universityInput,
              const SizedBox(height: c.defaultMargin),
              typeInput,
              const SizedBox(height: c.defaultMargin),
              startDateInput,
              const SizedBox(height: c.defaultMargin),
              endDateInput,
              const Divider(),
              commonPrompt,
            ],
          ),
        ),
      ),
    );
  }
}
