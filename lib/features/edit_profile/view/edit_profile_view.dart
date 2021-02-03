import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_education/view/education_widget.dart';
import 'package:helperr/features/edit_experience/view/experience_widget.dart';
import 'package:helperr/features/edit_languages/view/languages_widget.dart';

import 'package:helperr/features/edit_phone_numbers/view/phone_numbers_widget.dart';
import 'package:helperr/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:helperr/features/edit_sex/view/edit_sex_widget.dart';
import 'package:helperr/features/edit_social_links/view/social_links_widget.dart';

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
    final nameInput = TextFormField(
      initialValue: widget.worker.name,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        labelText: 'Имя',
        hintText: 'Полное имя',
      ),
      validator: (value) => value.isEmpty ? 'Имя должно быть указано' : null,
      onSaved: (newValue) => _name = newValue,
    );

    final aboutInput = TextFormField(
      initialValue: widget.worker.about,
      keyboardType: TextInputType.multiline,
      maxLength: 255,
      minLines: 2,
      maxLines: 4,
      decoration: const InputDecoration(
        labelText: 'О себе',
        hintText: 'Расскажите немного о себе...',
      ),
      onSaved: (newValue) => _about = newValue,
    );

    // TODO: allow to set empty
    final dobInput = InputDatePickerFormField(
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: widget.worker.birthday,
      fieldLabelText: 'Дата рождения',
      fieldHintText: 'мм/дд/гггг',
      errorInvalidText: 'Указана дата вне допустимого диапазона.',
      errorFormatText: 'Неверный формат даты.',
      onDateSaved: (value) => _dob = value,
    );

    // final dobPicker = IconButton(
    //   icon: const Icon(Icons.calendar_today_rounded),
    //   splashRadius: 24.0,
    //   onPressed: () {
    //     showDatePicker(
    //       context: context,
    //       initialDate: widget.worker.birthday,
    //       firstDate: DateTime(1900),
    //       lastDate: DateTime.now(),
    //     );
    //   },
    // );

    // final dobRow = Expanded(
    //   child: Row(
    //     children: [
    //       Expanded(child: dobInput),
    //       dobPicker,
    //     ],
    //   ),
    // );

    final genderInput = EditSex(
      initialValue: widget.worker.gender,
      onChanged: (value) => _gender = value,
    );

    final cityInput = TextFormField(
      initialValue: widget.worker.city,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Город',
        hintText: 'Город проживания',
      ),
      onSaved: (newValue) => _city = newValue,
    );

    final citizenshipInput = TextFormField(
      initialValue: widget.worker.cz,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Страна',
        hintText: 'Страна проживания',
      ),
      onSaved: (newValue) => _cz = newValue,
    );

    final phoneNumbersList = PhoneNumbers(
      initialValue: widget.worker.phone,
      onChanged: (newValue) => _phoneNumbers = newValue,
    );

    final educationList = EducationList(
      initialValue: widget.worker.education,
      onChanged: (newValue) => _education = newValue,
    );

    final experienceList = ExperienceList(
      initialValue: widget.worker.exp,
      onChanged: (newValue) => _experience = newValue,
    );

    final languagesList = LanguagesList(
      initialValue: widget.worker.language,
      onChanged: (newValue) => _languages = newValue,
    );

    final socialLinksList = SocialLinksList(
      initialValue: widget.worker.socialLinks,
      onChanged: (newValue) => _socialLinks = newValue,
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
          // TODO: create bottom only when loading indicator is needed
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
