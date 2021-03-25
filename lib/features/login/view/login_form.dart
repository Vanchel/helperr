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

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const textInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)));

    final emailInput = Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.mail_rounded),
          labelText: 'Email',
          hintText: 'email@example.com',
          helperText: '',
          border: textInputBorder,
        ),
        validator: (value) => value.isEmpty ? 'Email не указан' : null,
        onSaved: (newValue) => _email = newValue,
      ),
    );

    final passwordInput = Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock_rounded),
          labelText: 'Пароль',
          helperText: '',
          border: textInputBorder,
        ),
        validator: (value) => value.isEmpty ? 'Пароль не указан' : null,
        onSaved: (newValue) => _password = newValue,
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
          return Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  context.read<LoginCubit>().submitLogin(_email, _password);
                }
              },
              child: const Text('Войти'),
            ),
          );
        }
      },
    );

    final actionsRow = Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
          child: Text('Забыли пароль?'),
        ),
        TextButton(
          onPressed: () => Navigator.push(context, RegisterPage.route()),
          child: const Text('Зарегистрироваться'),
        ),
      ],
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
        padding: const EdgeInsets.all(constants.scaffoldBodyPadding),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              emailInput,
              passwordInput,
              loginButton,
              actionsRow,
            ],
          ),
        ),
      ),
    );
  }
}
