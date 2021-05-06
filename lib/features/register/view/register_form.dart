import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helperr/features/edit_single_value/views/user_type_toggle/user_type_toggle_widget.dart';

import '../../../constants.dart' as c;
import '../../../data_layer/model/user_type.dart';
import '../register.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _email;
  String _password;
  UserType _userType;

  bool _isValidPassword(String str) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{4,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(str);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(c.borderRadius)));

    final header = Container(
      padding: const EdgeInsets.all(c.defaultMargin * 2),
      child: SvgPicture.asset(
        'assets/sign-in.svg',
        height: 128.0,
        color: themeData.accentColor,
        colorBlendMode: BlendMode.srcATop,
      ),
    );

    final nameInput = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: TextFormField(
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person_rounded),
          labelText: 'Имя пользователя',
          hintText: 'Nickname',
          helperText: '',
          border: textInputBorder,
        ),
        validator: (value) =>
            value.isEmpty ? 'Имя пользователя не указано' : null,
        onSaved: (newValue) => _name = newValue,
      ),
    );

    final emailInput = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.mail_rounded),
          labelText: 'Email',
          hintText: 'email@example.com',
          helperText: '',
          border: textInputBorder,
        ),
        onSaved: (newValue) => _email = newValue,
      ),
    );

    const passwordHelper =
        'Пароль должен быть от 4 символов в длину и содержать хотя бы одну '
        'цифру, строчную и заглавную букву.';

    final passwordInput = Container(
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock_rounded),
          labelText: 'Пароль',
          helperText: passwordHelper,
          helperMaxLines: 4,
          errorMaxLines: 4,
          border: textInputBorder,
        ),
        validator: (value) => !_isValidPassword(value) ? passwordHelper : null,
        onSaved: (newValue) => _password = newValue,
      ),
    );

    final userTypeRow = Container(
      margin: const EdgeInsets.symmetric(vertical: c.defaultMargin * 2),
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Expanded(
            child: Text(
              'Тип пользователя:',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          UserTypeToggle(
            onChanged: (newValue) => _userType = newValue,
          ),
        ],
      ),
    );

    final registerButton = BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == RegisterStatus.inProgress) {
          return Align(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        } else
          return Container(
            margin: const EdgeInsets.only(bottom: c.defaultMargin),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  context
                      .read<RegisterCubit>()
                      .submitRegister(_name, _email, _password, _userType);
                }
              },
              child: const Text('Зарегистрироваться'),
            ),
          );
      },
    );

    final orRow = Container(
      margin: const EdgeInsets.symmetric(vertical: c.defaultMargin),
      child: Row(
        children: [
          Expanded(child: const Divider()),
          Text(
            'Уже есть аккаунт?',
            style: TextStyle(color: themeData.disabledColor),
          ),
          Expanded(child: const Divider()),
        ],
      ),
    );

    final loginButton = TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Войти'),
    );

    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status == RegisterStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              backgroundColor: Colors.black54,
              content: Text('Ошибка регистрации'),
            ));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(c.scaffoldBodyPadding),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  header,
                  nameInput,
                  emailInput,
                  passwordInput,
                  userTypeRow,
                  registerButton,
                  orRow,
                  loginButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
