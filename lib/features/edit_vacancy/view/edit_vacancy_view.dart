import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/widgets/custom_back_button.dart';

import '../cubit/edit_vacancy_cubit.dart';

import '../../../data_layer/repository/authentication_repository.dart';

import '../../../data_layer/model/experience_duration.dart';
import '../../../data_layer/model/work_type.dart';
import '../../../data_layer/model/address.dart';
import '../../../data_layer/model/experience_type.dart';
import '../../../data_layer/model/vacancy.dart';
import '../../../data_layer/model/scroll.dart';

import '../../edit_single_value/views/experience_type/edit_experience_type.dart';
import '../../edit_single_value/views/experience_duration/edit_experience_duration.dart';
import '../../edit_list/views/chip_input/chip_input_widget.dart';
import '../../edit_set/views/work_type_filter/work_type_filter_widget.dart';
import '../../edit_list/views/scroll/scroll_list.dart';

import '../../../constants.dart' as c;

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
  Set<WorkType> _workType;
  List<String> _tags;
  List<Scroll> _scrolls;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(c.borderRadius)));

    final vacancyNameInput = TextFormField(
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
    );

    final industryInput = TextFormField(
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
    );

    final leadingInput = TextFormField(
      initialValue: widget.isEditing ? widget.vacancy.leading : '',
      keyboardType: TextInputType.multiline,
      maxLength: 400,
      minLines: 4,
      maxLines: null,
      decoration: const InputDecoration(
        labelText: 'Введение',
        hintText: 'Ищем старательного сотрудника.',
        helperText: '',
        border: textInputBorder,
      ),
      onSaved: (newValue) => _leading = newValue,
    );

    final trailingInput = TextFormField(
      initialValue: widget.isEditing ? widget.vacancy.trailing : '',
      keyboardType: TextInputType.multiline,
      maxLength: 400,
      minLines: 4,
      maxLines: null,
      decoration: const InputDecoration(
        labelText: 'Заключение',
        hintText: 'Будем рады Вашему отклику.',
        helperText: '',
        border: textInputBorder,
      ),
      onSaved: (newValue) => _trailing = newValue,
    );

    final addressInput = TextFormField(
      initialValue: widget.isEditing ? widget.vacancy.address?.name : '',
      keyboardType: TextInputType.streetAddress,
      decoration: const InputDecoration(
        labelText: 'Адрес',
        hintText: 'г. Москва, ул. Пушкина, дом 2',
        helperText: '',
        border: textInputBorder,
      ),
      onSaved: (newValue) => _address = newValue,
    );

    final gradeInput = EditExperienceType(
      initialValue:
          widget.isEditing ? widget.vacancy.grade : ExperienceType.internship,
      onChanged: (value) => _grade = value,
    );

    final expInput = EditExperienceDuration(
      initialValue: widget.isEditing
          ? widget.vacancy.exp
          : ExperienceDuration.noExperience,
      onChanged: (value) => _experienceDuration = value,
    );

    final salaryInput = TextFormField(
      initialValue: widget.isEditing
          ? ((widget.vacancy.salary != -1) ? widget.vacancy.salary : '')
              .toString()
          : '',
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
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
      onSaved: (newValue) => _salary =
          newValue.isEmpty ? c.salaryNotSpecified : int.parse(newValue),
    );

    final workTypesFilter = Container(
      margin: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Типы работы',
              style: themeData.textTheme.bodyText1,
            ),
          ),
          WorkTypeFilter(
            initialValue: widget.isEditing ? widget.vacancy.workType : {},
            onChanged: (newValue) => _workType = newValue,
          ),
        ],
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

    final scrollsInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ScrollsList(
        initialValue: widget.isEditing ? widget.vacancy.body : [],
        onChanged: (newValue) => _scrolls = newValue,
      ),
    );

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
              style: OutlinedButton.styleFrom(primary: Colors.red),
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
          // TODO: temporary solution
          address: Address(name: _address, lat: 0.0, lng: 0.0),
          grade: _grade,
          exp: _experienceDuration,
          salary: _salary,
          workType: _workType,
          bgHeaderColor: '',
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
      leading: const CustomBackButton(),
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
            padding: const EdgeInsets.all(c.scaffoldBodyPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vacancyNameInput,
                const SizedBox(height: c.defaultMargin),
                industryInput,
                const SizedBox(height: c.defaultMargin),
                leadingInput,
                const SizedBox(height: c.defaultMargin),
                trailingInput,
                const SizedBox(height: c.defaultMargin),
                addressInput,
                const SizedBox(height: c.defaultMargin),
                gradeInput,
                const SizedBox(height: c.defaultMargin),
                expInput,
                const SizedBox(height: c.defaultMargin),
                salaryInput,
                const SizedBox(height: c.defaultMargin),
                workTypesFilter,
                tagsInput,
                scrollsInput,
                deleteBlock,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
