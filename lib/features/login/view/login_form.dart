import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart' as constants;
import '../../register/view/register_page.dart';
import '../login.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _name;
    String _password;

    final usernameInput = TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => _name = newValue,
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
      keyboardType: TextInputType.visiblePassword,
      onSaved: (newValue) => _password = newValue,
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
                _formKey.currentState.save();
                context.read<LoginCubit>().submitLogin(_name, _password);
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
          ScaffoldMessenger.of(context)
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
        padding: const EdgeInsets.all(constants.DEFAULT_SCAFFOLD_BODY_PADDING),
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
}
