part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({this.status, this.user});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated(User user)
      : this._(status: AuthenticationStatus.unauthenticated, user: user);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => [status];
}
