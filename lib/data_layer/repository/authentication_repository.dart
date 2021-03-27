import 'dart:async';

import 'package:meta/meta.dart';

import '../data_provider/helperr_server.dart' as server;
import '../model/user.dart';
import '../model/user_type.dart';

enum AuthenticationStatus { authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  User _user;

  Stream<AuthenticationStatus> get status async* {
    yield await _trySignInWithToken();
    yield* _controller.stream;
  }

  User get user => _user ?? User.empty;

  Future<AuthenticationStatus> _trySignInWithToken() async {
    try {
      final userId = await server.verifyCurrentRefreshToken();
      _user = await server.getUser(userId);
      return AuthenticationStatus.authenticated;
    } catch (e) {
      print(e);
      return AuthenticationStatus.unauthenticated;
    }
  }

  Future<void> logIn({
    @required String email,
    @required String password,
  }) async {
    assert(email != null);
    assert(password != null);

    _user = await server.login(email, password);
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

    _user = await server.register(name, email, password, userType);
    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
