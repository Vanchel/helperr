import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/widgets/custom_back_button.dart';

import '../cubit/edit_resume_cubit.dart';

import '../../../data_layer/repository/authentication_repository.dart';

import '../../../data_layer/model/work_type.dart';
import '../../../data_layer/model/experience_type.dart';
import '../../../data_layer/model/resume.dart';
import '../../../data_layer/model/portfolio.dart';

import '../../edit_single_value/views/experience_type/edit_experience_type.dart';
import '../../edit_list/views/chip_input/chip_input_widget.dart';
import '../../edit_set/views/work_type_filter/work_type_filter_widget.dart';
import '../../edit_list/views/portfolio/portfolio_list.dart';

import '../../../constants.dart' as c;

class EditResumeView extends StatefulWidget {
  EditResumeView({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.resume,
  }) : super(key: key);

  final VoidCallback onSave;
  final bool isEditing;
  final Resume resume;

  @override
  _EditResumeViewState createState() => _EditResumeViewState();
}

class _EditResumeViewState extends State<EditResumeView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _vacancyName;
  String _industry;
  String _about;
  ExperienceType _grade;
  int _salary;
  Set<WorkType> _workType;
  List<String> _tags;
  List<Portfolio> _portfolio;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(c.borderRadius)));

    final vacancyNameInput = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: TextFormField(
        initialValue: widget.isEditing ? widget.resume.vacancyName : '',
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
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: TextFormField(
        initialValue: widget.isEditing ? widget.resume.industry : '',
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

    final aboutInput = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: TextFormField(
        initialValue: widget.isEditing ? widget.resume.about : '',
        keyboardType: TextInputType.multiline,
        maxLength: 400,
        minLines: 4,
        maxLines: null,
        decoration: const InputDecoration(
          labelText: 'Описание резюме',
          hintText: 'Стараюсь найти работу по душе.',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _about = newValue,
      ),
    );

    final gradeInput = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin * 2),
      child: EditExperienceType(
        initialValue:
            widget.isEditing ? widget.resume.grade : ExperienceType.internship,
        onChanged: (value) => _grade = value,
      ),
    );

    final salaryInput = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: TextFormField(
        initialValue: widget.isEditing
            ? ((widget.resume.salary != c.salaryNotSpecified)
                    ? widget.resume.salary
                    : '')
                .toString()
            : '',
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          labelText: 'Желаемая зарплата',
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
              'Типы работы',
              style: themeData.textTheme.subtitle1,
            ),
          ),
          WorkTypeFilter(
            initialValue: widget.isEditing ? widget.resume.workType : {},
            onChanged: (newValue) => _workType = newValue,
          ),
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
        initialValue: widget.isEditing ? widget.resume.tags : [],
        onChanged: (newValue) => _tags = newValue,
        labelText: 'Добавить тег',
        hintText: 'Космос',
      ),
    );

    final portfolioList = Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      child: PortfolioList(
        initialValue: widget.isEditing ? widget.resume.portfolio : [],
        onChanged: (newValue) => _portfolio = newValue,
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
              'Если Вы хотите полностью удалить резюме из профиля, Вы '
              'можете сделать это, нажав на кнопку ниже.',
              style: themeData.textTheme.caption,
            ),
            const SizedBox(height: c.defaultMargin),
            OutlinedButton(
              child: const Text('Удалить резюме'),
              style: OutlinedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                context.read<EditResumeCubit>().deleteResume(widget.resume.id);
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

        Resume resume;
        if (widget.isEditing) {
          resume = widget.resume;
        } else {
          resume = Resume(
            userId: RepositoryProvider.of<AuthenticationRepository>(context)
                .user
                .id,
          );
        }

        final editedResume = resume.copyWith(
          vacancyName: _vacancyName,
          industry: _industry,
          about: _about,
          grade: _grade,
          salary: _salary,
          workType: _workType,
          tags: _tags,
          bgHeaderColor: '',
          portfolio: _portfolio,
        );

        if (widget.isEditing) {
          context.read<EditResumeCubit>().updateResume(editedResume);
        } else {
          context.read<EditResumeCubit>().addResume(editedResume);
        }
      }
    };

    final saveButton = BlocBuilder<EditResumeCubit, EditResumeState>(
      builder: (context, state) {
        return IconButton(
          icon: const Icon(Icons.check_rounded),
          splashRadius: c.iconButtonSplashRadius,
          onPressed: !(state is ResumeChangeInProgress) ? onSavePressed : null,
        );
      },
    );

    final progressIndicator = BlocBuilder<EditResumeCubit, EditResumeState>(
      builder: (context, state) {
        return (state is ResumeChangeInProgress)
            ? const LinearProgressIndicator()
            : const SizedBox.shrink();
      },
    );

    final listener = (BuildContext context, EditResumeState state) {
      if (state is ResumeChangeFailure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: Colors.black54,
              content: Text('Не удалось сохранить резюме'),
            ),
          );
      } else if (state is ResumeChangeSuccess) {
        widget.onSave();
        Navigator.pop(context);
      }
    };

    final appBar = AppBar(
      leading: const CustomBackButton(),
      title: Text(widget.isEditing ? 'Изменить резюме' : 'Добавить резюме'),
      actions: [saveButton],
      bottom: PreferredSize(
        child: progressIndicator,
        preferredSize: const Size.fromHeight(4.0),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: BlocListener<EditResumeCubit, EditResumeState>(
        listener: listener,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(c.scaffoldBodyPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vacancyNameInput,
                industryInput,
                aboutInput,
                gradeInput,
                salaryInput,
                workTypesFilter,
                tagsInput,
                portfolioList,
                deleteBlock,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
