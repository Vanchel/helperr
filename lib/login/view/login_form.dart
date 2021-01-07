import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login.dart';
import '../../register/view/register_page.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final usernameInput = TextFormField(
      controller: usernameController,
      decoration: const InputDecoration(
        icon: const Icon(Icons.mail_rounded),
        labelText: 'Логин',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Логин не указан';
        }
        return null;
      },
    );

    final passwordInput = TextFormField(
      controller: passwordController,
      decoration: const InputDecoration(
        icon: Icon(Icons.lock_rounded),
        labelText: 'Пароль',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Пароль не указан';
        }
        return null;
      },
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
    );

    final recoveryButton = Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {},
        child: Text('Забыли пароль?'),
      ),
    );

    final loginButton = BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == LoginStatus.inProgress) {
          return Align(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        } else {
          return ElevatedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                // сохранить данные локально через bloc
                context.read<LoginCubit>().submitLogin(
                      usernameController.text,
                      passwordController.text,
                    );
              }
            },
            child: const Text('Войти'),
          );
        }
      },
    );

    final registerButton = TextButton(
      onPressed: () => Navigator.push(context, RegisterPage.route()),
      child: const Text('Зарегистрироваться'),
    );

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            usernameInput,
            passwordInput,
            recoveryButton,
            loginButton,
            registerButton,
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
