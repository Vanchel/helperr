import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../register.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
    final nameInput = TextFormField(
      controller: nameController,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        icon: const Icon(Icons.person_rounded),
        labelText: 'Имя пользователя',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Имя пользователя не указано';
        }
        return null;
      },
    );

    final emailInput = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        icon: const Icon(Icons.mail_rounded),
        labelText: 'Email',
      ),
      validator: (value) {
        if (!_isValidEmail(value)) {
          return 'Введите корректный email';
        }
        return null;
      },
    );

    final passwordInput = TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      decoration: const InputDecoration(
        icon: Icon(Icons.lock_rounded),
        labelText: 'Пароль',
        errorMaxLines: 5,
      ),
      validator: (value) {
        if (!_isValidPassword(value)) {
          return 'Пароль должен быть длиной не менее 6 символов, содержать '
              'исключительно буквы латинского алфавита или цифры, иметь по '
              'меньшей мере одну заглавную букву и одну строчную букву, а '
              'также как минмум одну цифру.';
        }
        return null;
      },
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
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
                context.read<RegisterCubit>().submitRegister(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                      'employee',
                    );
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
          ScaffoldMessenger.of(context)
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
              registerButton,
              loginButton,
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
