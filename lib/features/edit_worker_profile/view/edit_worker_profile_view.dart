import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/gender.dart';
import 'package:helperr/features/edit_list/views/education/education_list.dart';
import 'package:helperr/features/edit_list/views/experience/experience_list.dart';
import 'package:helperr/features/edit_list/views/language/language_list.dart';
import 'package:helperr/features/edit_list/views/phone_number/phone_number_list.dart';
import 'package:helperr/features/edit_list/views/social_links/social_link_list.dart';
import 'package:helperr/features/edit_worker_profile/cubit/edit_profile_cubit.dart';
import 'package:helperr/widgets/date_input.dart';
import 'package:helperr/features/edit_single_value/views/sex/edit_sex_widget.dart';
import 'package:helperr/constants.dart' as constants;

import '../../../data_layer/model/models.dart';

class EditWorkerProfileView extends StatefulWidget {
  EditWorkerProfileView({Key key, @required this.onSave, @required this.worker})
      : super(key: key);

  final VoidCallback onSave;
  final Worker worker;

  @override
  _EditWorkerProfileViewState createState() => _EditWorkerProfileViewState();
}

class _EditWorkerProfileViewState extends State<EditWorkerProfileView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name;
  String _about;
  Gender _gender;
  DateTime _dob;
  String _address;
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
        maxLength: 150,
        maxLines: null,
        decoration: const InputDecoration(
          labelText: 'О себе',
          hintText: 'Любитель ракет и сладких конфет ^^,',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _about = newValue,
      ),
    );

    final dobInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: DateInput(
        initialValue: widget.worker.birthday,
        onValidate: (newValue) => _dob = newValue,
        labelText: 'Дата рождения',
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

    final addressInput = Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextFormField(
        initialValue: widget.worker.address.name,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Место проживания',
          hintText: 'Москва',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _address = newValue,
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
      child: PhoneNumberList(
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
      child: LanguageList(
        initialValue: widget.worker.language,
        onChanged: (newValue) => _languages = newValue,
      ),
    );

    final socialLinksList = Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      child: SocialLinkList(
        initialValue: widget.worker.socialLinks,
        onChanged: (newValue) => _socialLinks = newValue,
      ),
    );

    final divider = const Divider();

    final commonPrompt = Text(
      'Профиль отражает Ваши навыки и умения, а также некоторую общую '
      'информацию. Потенциальный работодатель может ознакомиться также и с '
      'Вашим профилем, если его заинтересует резюме.',
      style: themeData.textTheme.caption,
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
          // TODO: temporary solution
          address: Address(name: _address, lat: 0.0, lng: 0.0),
          cz: _cz,
          phone: _phoneNumbers,
          education: _education,
          exp: _experience,
          language: _languages,
          socialLinks: _socialLinks,
          profileLink: '',
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

    final appBar = AppBar(
      leading: backButton,
      title: const Text('Изменить профиль'),
      actions: [submitButton],
      bottom: PreferredSize(
        child: progressIndicator,
        preferredSize: const Size.fromHeight(4.0),
      ),
    );

    final listener = (BuildContext context, EditProfileState state) {
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
    };

    return Scaffold(
      appBar: appBar,
      body: BlocListener<EditProfileCubit, EditProfileState>(
        listener: listener,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(constants.scaffoldBodyPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nameInput,
                aboutInput,
                dobInput,
                genderInput,
                addressInput,
                citizenshipInput,
                phoneNumbersList,
                educationList,
                experienceList,
                languagesList,
                socialLinksList,
                divider,
                commonPrompt,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
