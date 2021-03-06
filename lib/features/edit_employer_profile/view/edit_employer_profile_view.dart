import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_employer_profile/cubit/edit_profile_cubit.dart';
import 'package:helperr/features/edit_list/views/phone_number/phone_number_list.dart';
import 'package:helperr/features/edit_list/views/social_links/social_link_list.dart';
import 'package:helperr/constants.dart' as constants;

import '../../../data_layer/model/models.dart';

class EditEmployerProfileView extends StatefulWidget {
  EditEmployerProfileView({
    Key key,
    @required this.onSave,
    @required this.employer,
  }) : super(key: key);

  final VoidCallback onSave;
  final Employer employer;

  @override
  _EditEmployerProfileViewState createState() =>
      _EditEmployerProfileViewState();
}

class _EditEmployerProfileViewState extends State<EditEmployerProfileView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    String _name;
    String _about;
    String _address;
    List<String> _phoneNumbers;
    List<String> _links;

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)));

    final nameInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.employer.name,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          labelText: 'Название организации',
          hintText: 'Байконур inc.',
          helperText: '',
          border: textInputBorder,
        ),
        validator: (value) =>
            value.isEmpty ? 'Название организации должно быть указано' : null,
        onSaved: (newValue) => _name = newValue,
      ),
    );

    final aboutInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.employer.about,
        keyboardType: TextInputType.multiline,
        maxLength: 150,
        minLines: 1,
        maxLines: 4,
        decoration: const InputDecoration(
          labelText: 'О компании',
          hintText: 'Строим ракеты, едим конфеты >_<',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _about = newValue,
      ),
    );

    final addressInput = Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextFormField(
        initialValue: widget.employer.address,
        keyboardType: TextInputType.streetAddress,
        decoration: const InputDecoration(
          labelText: 'Адрес',
          hintText: 'г. Москва, ул. Ленина, дом 1',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _address = newValue,
      ),
    );

    final phoneNumbersList = Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      child: PhoneNumberList(
        initialValue: widget.employer.phone,
        onChanged: (newValue) => _phoneNumbers = newValue,
      ),
    );

    final linksList = Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      child: SocialLinkList(
        initialValue: widget.employer.links,
        onChanged: (newValue) => _links = newValue,
      ),
    );

    final divider = const Divider();

    final commonPrompt = Text(
      'Профиль отражает отличительные черты Вашей компании, а также некоторую '
      'общую информацию. Соискатели могут ознакомиться также и с профилем, '
      'если их заинтересует одна из ваших вакансий.',
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
        final editedEmployer = widget.employer.copyWith(
          name: _name,
          about: _about,
          address: _address,
          phone: _phoneNumbers,
          links: _links,
          profileLink: "",
        );
        context.read<EditProfileCubit>().saveProfile(editedEmployer);
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
                addressInput,
                phoneNumbersList,
                linksList,
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
