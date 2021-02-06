import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_education/view/education_widget.dart';
import 'package:helperr/features/edit_experience/view/experience_widget.dart';
import 'package:helperr/features/edit_languages/view/languages_widget.dart';

import 'package:helperr/features/edit_phone_numbers/view/phone_numbers_widget.dart';
import 'package:helperr/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:helperr/features/edit_sex/view/edit_sex_widget.dart';
import 'package:helperr/features/edit_social_links/view/social_links_widget.dart';
import 'package:intl/intl.dart';

import '../../../data_layer/model/worker.dart';

class EditProfileView extends StatefulWidget {
  EditProfileView({Key key, @required this.onSave, @required this.worker})
      : super(key: key);

  final VoidCallback onSave;
  final Worker worker;

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name;
  String _about;
  Gender _gender;
  DateTime _dob;
  String _city;
  String _cz;
  List<String> _phoneNumbers;
  List<Education> _education;
  List<Exp> _experience;
  List<Language> _languages;
  List<String> _socialLinks;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)));

    final nameInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.worker.name,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          labelText: 'Имя',
          hintText: 'Иван Петров',
          helperText: '',
          border: textInputBorder,
        ),
        validator: (value) => value.isEmpty ? 'Имя должно быть указано' : null,
        onSaved: (newValue) => _name = newValue,
      ),
    );

    final aboutInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.worker.about,
        keyboardType: TextInputType.multiline,
        maxLength: 80,
        decoration: const InputDecoration(
          labelText: 'О себе',
          hintText: 'Любитель ракет и сладких конфет ^^,',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _about = newValue,
      ),
    );

    // // TODO: allow to set empty
    // final dobInput = InputDatePickerFormField(
    //   firstDate: DateTime(1900),
    //   lastDate: DateTime.now(),
    //   initialDate: widget.worker.birthday,
    //   fieldLabelText: 'Дата рождения',
    //   fieldHintText: 'мм/дд/гггг',
    //   errorInvalidText: 'Указана дата вне допустимого диапазона.',
    //   errorFormatText: 'Неверный формат даты.',
    //   onDateSaved: (value) => _dob = value,
    // );

    // start from creating datepicker input widget
    final dobPicker = Container(
      margin: const EdgeInsets.only(right: 6.0),
      child: IconButton(
        icon: const Icon(Icons.calendar_today_rounded),
        splashRadius: 24.0,
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: widget.worker.birthday,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
        },
      ),
    );

    final dobInput = Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        initialValue: DateFormat('dd.MM.yyyy').format(widget.worker.birthday),
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          labelText: 'Дата рождения',
          hintText: 'дд.мм.гггг',
          helperText: '',
          border: textInputBorder,
          suffixIcon: dobPicker,
        ),
        validator: (value) {
          try {
            if (value == '') {
              _dob = null;
              return null;
            }

            final val = value.split('.').reversed.join();
            _dob = DateTime.parse(val);
            return null;
          } catch (_) {
            return 'Неверный формат даты.';
          }
        },
      ),
    );

    final genderInput = Container(
      margin: const EdgeInsets.only(bottom: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Пол', style: themeData.textTheme.bodyText1),
          EditSex(
            initialValue: widget.worker.gender,
            onChanged: (value) => _gender = value,
          ),
        ],
      ),
    );

    final cityInput = Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextFormField(
        initialValue: widget.worker.city,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Город',
          hintText: 'Москва',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _city = newValue,
      ),
    );

    final citizenshipInput = Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        initialValue: widget.worker.cz,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Страна',
          hintText: 'Россия',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _cz = newValue,
      ),
    );

    final phoneNumbersList = Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      child: PhoneNumbers(
        initialValue: widget.worker.phone,
        onChanged: (newValue) => _phoneNumbers = newValue,
      ),
    );

    final educationList = Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      child: EducationList(
        initialValue: widget.worker.education,
        onChanged: (newValue) => _education = newValue,
      ),
    );

    final experienceList = Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      child: ExperienceList(
        initialValue: widget.worker.exp,
        onChanged: (newValue) => _experience = newValue,
      ),
    );

    final languagesList = Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      child: LanguagesList(
        initialValue: widget.worker.language,
        onChanged: (newValue) => _languages = newValue,
      ),
    );

    final socialLinksList = Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      child: SocialLinksList(
        initialValue: widget.worker.socialLinks,
        onChanged: (newValue) => _socialLinks = newValue,
      ),
    );

    final backButton = IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      splashRadius: 24.0,
      onPressed: () => Navigator.pop(context),
    );

    final onSubmitPressed = () {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        final editedWorker = widget.worker.copyWith(
          name: _name,
          about: _about,
          birthday: _dob,
          gender: _gender,
          city: _city,
          cz: _cz,
          phone: _phoneNumbers,
          education: _education,
          exp: _experience,
          language: _languages,
          socialLinks: _socialLinks,
        );
        context.read<EditProfileCubit>().saveProfile(editedWorker);
      }
    };

    final progressIndicator = BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        return (state is ProfileSaveInProgress)
            ? const LinearProgressIndicator()
            : const SizedBox.shrink();
      },
    );

    final submitButton = BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        return IconButton(
          icon: const Icon(Icons.check_rounded),
          splashRadius: 24.0,
          onPressed: !(state is ProfileSaveInProgress) ? onSubmitPressed : null,
        );
      },
    );

    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is ProfileSaveFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.black54,
                content: Text('Не удалось обновить профиль'),
              ),
            );
        } else if (state is ProfileSaveSuccess) {
          widget.onSave();
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: backButton,
          title: const Text('Изменить профиль'),
          actions: [submitButton],
          bottom: PreferredSize(
            child: progressIndicator,
            preferredSize: const Size.fromHeight(4.0),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nameInput,
                aboutInput,
                dobInput,
                genderInput,
                cityInput,
                citizenshipInput,
                phoneNumbersList,
                educationList,
                experienceList,
                languagesList,
                socialLinksList,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
