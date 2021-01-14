import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data_layer/repository/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  Future<void> submitLogin(String email, String password) async {
    emit(const LoginState(status: LoginStatus.inProgress));
    try {
      await _authenticationRepository.logIn(
        email: email,
        password: password,
      );
      emit(const LoginState(status: LoginStatus.success));
    } on Exception catch (_) {
      emit(const LoginState(status: LoginStatus.failure));
    }
  }
}
