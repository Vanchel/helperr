import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_single_value/views/experience_duration/edit_experience_duration.dart';

import '../../../data_layer/repository/authentication_repository.dart';
import '../../../data_layer/model/experience_type.dart';
import '../../../data_layer/model/experience_duration.dart';
import '../../../data_layer/model/vacancy.dart';
import '../../../data_layer/model/scroll.dart';

import '../cubit/edit_vacancy_cubit.dart';
import '../../edit_single_value/views/experience_type/edit_experience_type.dart';
import '../../../widgets/chip_input/view/chip_input_widget.dart';
import '../../../constants.dart' as constants;

class EditVacancyView extends StatefulWidget {
  EditVacancyView({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.vacancy,
  }) : super(key: key);

  final VoidCallback onSave;
  final bool isEditing;
  final Vacancy vacancy;

  @override
  _EditVacancyViewState createState() => _EditVacancyViewState();
}

class _EditVacancyViewState extends State<EditVacancyView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _vacancyName;
  String _industry;
  String _leading;
  String _trailing;
  String _address;
  ExperienceType _grade;
  ExperienceDuration _experienceDuration;
  int _salary;
  List<String> _workType;
  List<String> _tags;
  List<Scroll> _scrolls = [
    Scroll(title: 'Тест', subtitle: 'Тест', points: ['1', '2', '3'])
  ];

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)));

    final vacancyNameInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.isEditing ? widget.vacancy.vacancyName : '',
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Название вакансии',
          hintText: 'Пилот лунного модуля',
          helperText: '',
          border: textInputBorder,
        ),
        validator: (value) =>
            value.isEmpty ? 'Название вакансии должно быть указано' : null,
        onSaved: (newValue) => _vacancyName = newValue,
      ),
    );

    final industryInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.isEditing ? widget.vacancy.industry : '',
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Название отрасли',
          hintText: 'Космонавтика',
          helperText: '',
          border: textInputBorder,
        ),
        validator: (value) =>
            value.isEmpty ? 'Название отрасли должно быть указано' : null,
        onSaved: (newValue) => _industry = newValue,
      ),
    );

    final leadingInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.isEditing ? widget.vacancy.leading : '',
        keyboardType: TextInputType.multiline,
        maxLength: 400,
        minLines: 1,
        maxLines: 4,
        decoration: const InputDecoration(
          labelText: 'Введение',
          hintText: 'Ищем старательного сотрудника.',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _leading = newValue,
      ),
    );

    final trailingInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.isEditing ? widget.vacancy.trailing : '',
        keyboardType: TextInputType.multiline,
        maxLength: 400,
        minLines: 1,
        maxLines: 4,
        decoration: const InputDecoration(
          labelText: 'Заключение',
          hintText: 'Будем рады Вашему отклику.',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _trailing = newValue,
      ),
    );

    final addressInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.isEditing ? widget.vacancy.address : '',
        keyboardType: TextInputType.streetAddress,
        decoration: const InputDecoration(
          labelText: 'Адрес',
          hintText: 'г. Москва, ул. Пушкина, дом 2',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _address = newValue,
      ),
    );

    final gradeInput = Container(
      margin: const EdgeInsets.only(bottom: 38.0),
      child: EditExperienceType(
        initialValue:
            widget.isEditing ? widget.vacancy.grade : ExperienceType.internship,
        onChanged: (value) => _grade = value,
      ),
    );

    final expInput = Container(
      margin: const EdgeInsets.only(bottom: 38.0),
      child: EditExperienceDuration(
        initialValue: widget.isEditing
            ? widget.vacancy.exp
            : ExperienceDuration.noExperience,
        onChanged: (value) => _experienceDuration = value,
      ),
    );

    final salaryInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue:
            widget.isEditing ? (widget.vacancy.salary ?? '').toString() : '',
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Предполагаемая зарплата',
          hintText: '15000',
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
        onSaved: (newValue) => _salary = newValue.isEmpty
            ? constants.SALARY_NOT_SPECIFIED
            : int.parse(newValue),
      ),
    );

    final workTypesInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ChipInput(
        initialValue: widget.isEditing ? widget.vacancy.workType : [],
        onChanged: (newValue) => _workType = newValue,
        labelText: 'Добавить тип работы',
        hintText: 'Воздухоплавание',
      ),
    );

    final tagsInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ChipInput(
        initialValue: widget.isEditing ? widget.vacancy.tags : [],
        onChanged: (newValue) => _tags = newValue,
        labelText: 'Добавить тег',
        hintText: 'Космос',
      ),
    );

    // body

    Widget deleteBlock;
    if (widget.isEditing) {
      deleteBlock = Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(),
            Text(
              'Если Вы хотите полностью удалить вакансию из профиля, Вы '
              'можете сделать это, нажав на кнопку ниже.',
              style: themeData.textTheme.caption,
            ),
            const SizedBox(height: 16.0),
            OutlinedButton(
              child: const Text('Удалить вакансию'),
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.red),
              ),
              onPressed: () {
                context
                    .read<EditVacancyCubit>()
                    .deleteVacancy(widget.vacancy.id);
              },
            ),
          ],
        ),
      );
    } else {
      deleteBlock = const SizedBox.shrink();
    }

    final backButton = IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      splashRadius: 24.0,
      onPressed: () => Navigator.pop(context),
    );

    final onSavePressed = () {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        Vacancy vacancy;
        if (widget.isEditing) {
          vacancy = widget.vacancy;
        } else {
          vacancy = Vacancy(
            userId: RepositoryProvider.of<AuthenticationRepository>(context)
                .user
                .id,
          );
        }

        final editedVacancy = vacancy.copyWith(
          vacancyName: _vacancyName,
          industry: _industry,
          leading: _leading,
          trailing: _trailing,
          address: _address,
          grade: _grade,
          exp: _experienceDuration,
          salary: _salary,
          workType: _workType,
          tags: _tags,
          body: _scrolls,
        );

        if (widget.isEditing) {
          context.read<EditVacancyCubit>().updateVacancy(editedVacancy);
        } else {
          context.read<EditVacancyCubit>().addVacancy(editedVacancy);
        }
      }
    };

    final saveButton = BlocBuilder<EditVacancyCubit, EditVacancyState>(
      builder: (context, state) {
        return IconButton(
          icon: const Icon(Icons.check_rounded),
          splashRadius: 24.0,
          onPressed: !(state is VacancyChangeInProgress) ? onSavePressed : null,
        );
      },
    );

    final progressIndicator = BlocBuilder<EditVacancyCubit, EditVacancyState>(
      builder: (context, state) {
        return (state is VacancyChangeInProgress)
            ? const LinearProgressIndicator()
            : const SizedBox.shrink();
      },
    );

    final listener = (BuildContext context, EditVacancyState state) {
      if (state is VacancyChangeFailure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: Colors.black54,
              content: Text('Не удалось сохранить вакансию'),
            ),
          );
      } else if (state is VacancyChangeSuccess) {
        widget.onSave();
        Navigator.pop(context);
      }
    };

    final appBar = AppBar(
      leading: backButton,
      title: Text(widget.isEditing ? 'Изменить вакансию' : 'Добавить вакансию'),
      actions: [saveButton],
      bottom: PreferredSize(
        child: progressIndicator,
        preferredSize: const Size.fromHeight(4.0),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: BlocListener<EditVacancyCubit, EditVacancyState>(
        listener: listener,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vacancyNameInput,
                industryInput,
                leadingInput,
                trailingInput,
                addressInput,
                gradeInput,
                expInput,
                salaryInput,
                workTypesInput,
                tagsInput,
                // scrollsInput,
                deleteBlock,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
