part of 'register_cubit.dart';

enum RegisterStatus { pure, inProgress, success, failure }

@immutable
class RegisterState extends Equatable {
  const RegisterState({this.status = RegisterStatus.pure});

  final RegisterStatus status;

  @override
  List<Object> get props => [status];
}
