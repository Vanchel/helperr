import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data_layer/authentication_repository/src/authentication_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const RegisterState());

  final AuthenticationRepository _authenticationRepository;

  Future<void> submitRegister(
      String name, String email, String password, String userType) async {
    emit(const RegisterState(status: RegisterStatus.inProgress));
    try {
      await _authenticationRepository.register(
        name: name,
        email: email,
        password: password,
        userType: userType,
      );
      emit(const RegisterState(status: RegisterStatus.success));
    } on Exception catch (_) {
      emit(const RegisterState(status: RegisterStatus.success));
    }
  }
}
