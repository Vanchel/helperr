import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../register/view/register_page.dart';
import '../login.dart';

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
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        icon: const Icon(Icons.mail_rounded),
        labelText: 'Email',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Email не указан';
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

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.failure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.black54,
                content: Text('Ошибка входа'),
              ),
            );
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
              usernameInput,
              passwordInput,
              recoveryButton,
              loginButton,
              registerButton,
            ],
          ),
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
