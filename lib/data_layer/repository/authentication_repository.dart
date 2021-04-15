import 'dart:async';

import 'package:meta/meta.dart';

import '../data_provider/authentication_api_client.dart';
import '../model/user.dart';
import '../model/user_type.dart';

enum AuthenticationStatus { authenticated, unauthenticated }

class AuthenticationRepository {
  final AuthenticationApiClient authenticationApiClient;
  final _controller = StreamController<AuthenticationStatus>();
  User _user;

  AuthenticationRepository({@required this.authenticationApiClient})
      : assert(authenticationApiClient != null);

  Stream<AuthenticationStatus> get status async* {
    try {
      _user = await authenticationApiClient.loginAuto();
      yield AuthenticationStatus.authenticated;
    } catch (_) {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  User get user => _user ?? User.empty;

  Future<void> logIn({
    @required String email,
    @required String password,
  }) async {
    assert(email != null);
    assert(password != null);

    _user = await authenticationApiClient.login(email, password);
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> register({
    @required String name,
    @required String email,
    @required String password,
    @required UserType userType,
  }) async {
    assert(name != null);
    assert(email != null);
    assert(password != null);
    assert(userType != null);

    _user =
        await authenticationApiClient.register(name, email, password, userType);
    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() {
    authenticationApiClient.logout();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
