import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../edit_single_value/views/experience_type/edit_experience_type.dart';
import '../../../data_layer/repository/authentication_repository.dart';
import '../../../data_layer/model/experience_type.dart';
import '../../../data_layer/model/resume.dart';
import '../../../data_layer/model/portfolio.dart';

import '../cubit/edit_resume_cubit.dart';
import '../../edit_list/views/portfolio/portfolio_list.dart';
import '../../../widgets/chip_input/view/chip_input_widget.dart';
import '../../../constants.dart' as constants;

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
  List<String> _workType;
  List<String> _tags;
  List<Portfolio> _portfolio;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)));

    final vacancyNameInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
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
      margin: const EdgeInsets.only(bottom: 16.0),
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
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.isEditing ? widget.resume.about : '',
        keyboardType: TextInputType.multiline,
        maxLength: 400,
        minLines: 1,
        maxLines: 4,
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
      margin: const EdgeInsets.only(bottom: 38.0),
      child: EditExperienceType(
        initialValue:
            widget.isEditing ? widget.resume.grade : ExperienceType.internship,
        onChanged: (value) => _grade = value,
      ),
    );

    final salaryInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue:
            widget.isEditing ? (widget.resume.salary ?? '').toString() : '',
        keyboardType: TextInputType.number,
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
        onSaved: (newValue) => _salary = newValue.isEmpty
            ? constants.SALARY_NOT_SPECIFIED
            : int.parse(newValue),
      ),
    );

    final workTypesInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ChipInput(
        initialValue: widget.isEditing ? widget.resume.workType : [],
        onChanged: (newValue) => _workType = newValue,
        labelText: 'Добавить тип работы',
        hintText: 'Воздухоплавание',
      ),
    );

    final tagsInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
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
            const SizedBox(height: 16.0),
            OutlinedButton(
              child: const Text('Удалить резюме'),
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.red),
              ),
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

    final backButton = IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      splashRadius: 24.0,
      onPressed: () => Navigator.pop(context),
    );

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
          splashRadius: 24.0,
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
      leading: backButton,
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
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vacancyNameInput,
                industryInput,
                aboutInput,
                gradeInput,
                salaryInput,
                workTypesInput,
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
