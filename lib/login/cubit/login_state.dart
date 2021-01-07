part of 'login_cubit.dart';

enum LoginStatus { pure, inProgress, success, failure }

@immutable
class LoginState extends Equatable {
  const LoginState({this.status = LoginStatus.pure});

  final LoginStatus status;

  @override
  List<Object> get props => [status];
}
