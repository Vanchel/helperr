import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_single_value/views/user_type_toggle/user_type_toggle_widget.dart';

import '../../../data_layer/model/user_type.dart';
import '../register.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isValidEmail(String str) {
    String pattern =
        r'^(([^<>()[]\.,;:\s@"]+(.[^<>()[]\.,;:\s@"]+)*)|(".+"))@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])|(([a-zA-Z-0-9]+.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(str);
  }

  bool _isValidPassword(String str) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(str);
  }

  @override
  Widget build(BuildContext context) {
    String _name;
    String _email;
    String _password;
    UserType _userType;

    final nameInput = TextFormField(
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        icon: const Icon(Icons.person_rounded),
        labelText: 'Имя пользователя',
      ),
      onSaved: (newValue) => _name = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return 'Имя пользователя не указано.';
        }
        return null;
      },
    );

    final emailInput = TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => _email = newValue,
      decoration: const InputDecoration(
        icon: const Icon(Icons.mail_rounded),
        labelText: 'Email',
      ),
      validator: (value) {
        // if (!_isValidEmail(value)) {
        //   return 'Введите корректный email.';
        // }
        return null;
      },
    );

    final passwordInput = TextFormField(
      keyboardType: TextInputType.visiblePassword,
      scrollPadding: const EdgeInsets.only(bottom: 32.0),
      onSaved: (newValue) => _password = newValue,
      decoration: const InputDecoration(
        icon: Icon(Icons.lock_rounded),
        labelText: 'Пароль',
      ),
      validator: (value) {
        if (!_isValidPassword(value)) {
          return 'Пароль не соответствует критериям.';
        }
        return null;
      },
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
    );

    final userTypeToggle = Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      alignment: Alignment.center,
      child: UserTypeToggle(
        onChanged: (newValue) => _userType = newValue,
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
          return ElevatedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                context
                    .read<RegisterCubit>()
                    .submitRegister(_name, _email, _password, _userType);
              }
            },
            child: const Text('Зарегистрироваться'),
          );
      },
    );

    final loginButton = TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Войти'),
    );

    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status == RegisterStatus.failure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              backgroundColor: Colors.black54,
              content: Text('Ошибка регистрации'),
            ));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              nameInput,
              emailInput,
              passwordInput,
              userTypeToggle,
              registerButton,
              loginButton,
            ],
          ),
        ),
      ),
    );
  }
}
