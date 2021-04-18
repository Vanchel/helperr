import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helperr/widgets/custom_back_button.dart';

import '../../../edit_single_value/views/publication_age/edit_publication_age.dart';
import '../../../edit_list/views/chip_input/chip_input_widget.dart';
import '../../../edit_set/views/experience_type_filter/experience_type_filter_widget.dart';
import '../../../edit_set/views/work_type_filter/work_type_filter_widget.dart';

import '../../../../data_layer/model/resume_search_options.dart';
import '../../../../data_layer/model/experience_type.dart';
import '../../../../data_layer/model/work_type.dart';
import '../../../../data_layer/model/publication_age.dart';

import '../../../../constants.dart' as c;

class ResumeFilterPage extends StatefulWidget {
  ResumeFilterPage({
    Key key,
    this.query = '',
    @required this.onSave,
  }) : super(key: key);

  final String query;
  final Function(ResumeSearchOptions) onSave;

  @override
  _ResumeFilterPageState createState() => _ResumeFilterPageState();
}

class _ResumeFilterPageState extends State<ResumeFilterPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _searchPhrase;
  String _industry;
  int _maxSalary;
  Set<ExperienceType> _expTypes;
  Set<WorkType> _workTypes;
  List<String> _tags;
  PublicationAge _pubAge;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(c.borderRadius)));

    final searchQueryInput = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: TextFormField(
        initialValue: widget.query ?? '',
        autofocus: true,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Поиск',
          hintText: 'Ключевые слова',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _searchPhrase = newValue,
      ),
    );

    final industryInput = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Название отрасли',
          hintText: 'Космонавтика',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _industry = newValue,
      ),
    );

    final maxSalaryInput = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          labelText: 'Максимальная зарплата',
          hintText: '30000',
          helperText: '',
          border: textInputBorder,
          suffix: Container(
            margin: const EdgeInsets.only(right: 6.0),
            child: const Text('руб.'),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) return null;
          try {
            int.parse(value);
            return null;
          } catch (_) {
            return 'Неверный формат целого числа.';
          }
        },
        onSaved: (newValue) =>
            _maxSalary = newValue.isEmpty ? null : int.parse(newValue),
      ),
    );

    final experienceTypesFilter = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: c.defaultMargin),
            child: Text(
              'Уровень должности',
              style: themeData.textTheme.subtitle1,
            ),
          ),
          ExperienceTypeFilter(onChanged: (newValue) => _expTypes = newValue),
          Container(
            margin: const EdgeInsets.only(top: c.defaultMargin),
            child: const Divider(),
          ),
        ],
      ),
    );

    final workTypesFilter = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: c.defaultMargin),
            child: Text(
              'Тип работы',
              style: themeData.textTheme.subtitle1,
            ),
          ),
          WorkTypeFilter(onChanged: (newValue) => _workTypes = newValue),
          Container(
            margin: const EdgeInsets.symmetric(vertical: c.defaultMargin),
            child: const Divider(),
          ),
        ],
      ),
    );

    final tagsInput = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: ChipInput(
        onChanged: (newValue) => _tags = newValue,
        labelText: 'Искать тег',
        hintText: 'Космос',
      ),
    );

    final pubAgeInput = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: EditPublicationAge(
        onChanged: (value) => _pubAge = value,
      ),
    );

    final onSavePressed = () {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        final editedVacancyOptions = ResumeSearchOptions(
          searchPhrase: _searchPhrase,
          industry: _industry,
          maxSalary: _maxSalary,
          expTypes: _expTypes,
          workTypes: _workTypes,
          tags: _tags,
          pubAge: _pubAge,
        );
        widget.onSave(editedVacancyOptions);

        Navigator.pop(context);
      }
    };

    final saveButton = IconButton(
      icon: const Icon(Icons.check_rounded),
      splashRadius: c.iconButtonSplashRadius,
      onPressed: onSavePressed,
    );

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text('Фильтры'),
        actions: [saveButton],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(c.scaffoldBodyPadding),
          children: [
            searchQueryInput,
            industryInput,
            maxSalaryInput,
            experienceTypesFilter,
            workTypesFilter,
            tagsInput,
            pubAgeInput,
          ],
        ),
      ),
    );
  }
}
