import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data_layer/authentication_repository/authentication_repository.dart';

import '../register.dart';
import 'register_form.dart';
import '../../widgets/authentication_decorator.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        authenticationRepository:
            RepositoryProvider.of<AuthenticationRepository>(context),
      ),
      child: AuthenticationDecorator(child: RegisterForm()),
    );
  }
}
