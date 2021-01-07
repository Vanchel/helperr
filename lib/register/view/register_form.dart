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

  @override
  Widget build(BuildContext context) {
    final nameInput = TextFormField(
      controller: nameController,
      decoration: const InputDecoration(
        icon: const Icon(Icons.person_rounded),
        labelText: 'Имя пользователя',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Имя не указано';
        }
        return null;
      },
    );

    final emailInput = TextFormField(
      controller: emailController,
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
                // повторить то, что будет сделано в login
                context.read<RegisterCubit>().submitRegister(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                      'worker',
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

    return Container(
      padding: const EdgeInsets.all(8.0),
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
    );
  }
}
