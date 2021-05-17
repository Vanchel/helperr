import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/gender.dart';
import 'package:helperr/features/edit_list/views/education/education_list.dart';
import 'package:helperr/features/edit_list/views/experience/experience_list.dart';
import 'package:helperr/features/edit_list/views/language/language_list.dart';
import 'package:helperr/features/edit_list/views/phone_number/phone_number_list.dart';
import 'package:helperr/features/edit_list/views/social_links/social_link_list.dart';
import 'package:helperr/features/edit_set/views/schedule/schedules_page.dart';
import 'package:helperr/features/edit_worker_profile/cubit/edit_profile_cubit.dart';
import 'package:helperr/widgets/address_input/view/address_input.dart';
import 'package:helperr/widgets/custom_back_button.dart';
import 'package:helperr/widgets/date_input.dart';
import 'package:helperr/features/edit_single_value/views/sex/edit_sex_widget.dart';
import 'package:helperr/constants.dart' as c;

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
  Address _address;
  String _cz;
  List<Schedule> _schedules;
  List<String> _phoneNumbers;
  List<Education> _education;
  List<Exp> _experience;
  List<Language> _languages;
  List<String> _socialLinks;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(c.borderRadius)));

    final nameInput = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
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
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
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
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: DateInput(
        initialValue: widget.worker.birthday,
        onValidate: (newValue) => _dob = newValue,
        labelText: 'Дата рождения',
      ),
    );

    final genderInput = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Пол', style: themeData.textTheme.subtitle1),
          const SizedBox(height: c.defaultMargin),
          EditSex(
            initialValue: widget.worker.gender,
            onChanged: (value) => _gender = value,
          ),
        ],
      ),
    );

    final addressInput = Container(
      margin: const EdgeInsets.symmetric(vertical: c.defaultMargin),
      child: AddressInput(
        initialValue: widget.worker.address,
        onUpdated: (address) => _address = address,
        labelText: 'Место проживания',
        hintText: 'Москва',
        helperText: '',
      ),
    );

    final citizenshipInput = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: TextFormField(
        initialValue: widget.worker.cz,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Гражданство',
          hintText: 'Россия',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _cz = newValue,
      ),
    );

    final schedulesRow = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Желаемый график',
              style: themeData.textTheme.subtitle1,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          OutlinedButton(
            child: Text('Настроить'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return SchedulesPage(
                    initialValue:
                        Set.from(_schedules ?? widget.worker.schedules),
                    onChanged: (newValue) => _schedules = List.from(newValue),
                  );
                },
              ));
            },
          ),
        ],
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

    final divider = const Divider(height: 1);

    final commonPrompt = Text(
      'Профиль отражает Ваши навыки и умения, а также некоторую общую '
      'информацию. Потенциальный работодатель может ознакомиться также и с '
      'Вашим профилем, если его заинтересует резюме.',
      style: themeData.textTheme.caption,
    );

    final onSubmitPressed = () {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        final editedWorker = widget.worker.copyWith(
          name: _name,
          about: _about,
          birthday: _dob,
          gender: _gender,
          address: _address,
          cz: _cz,
          schedules: _schedules,
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
          splashRadius: c.iconButtonSplashRadius,
          onPressed: !(state is ProfileSaveInProgress) ? onSubmitPressed : null,
        );
      },
    );

    final appBar = AppBar(
      leading: const CustomBackButton(),
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
            padding: const EdgeInsets.all(c.scaffoldBodyPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nameInput,
                aboutInput,
                dobInput,
                genderInput,
                addressInput,
                citizenshipInput,
                schedulesRow,
                phoneNumbersList,
                divider,
                educationList,
                divider,
                experienceList,
                divider,
                languagesList,
                divider,
                socialLinksList,
                const Divider(),
                commonPrompt,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
