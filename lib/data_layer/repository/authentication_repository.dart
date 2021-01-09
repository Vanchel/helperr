import 'dart:async';

import 'package:meta/meta.dart';

import '../data_provider/helperr_server.dart' as server;
import '../data_provider/shared_preferences.dart' as preferences;
import '../model/user.dart';

enum AuthenticationStatus { authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  User user;

  Stream<AuthenticationStatus> get status async* {
    final data = await preferences.getLoginData();
    if (data != null) {
      logIn(email: data.email, password: data.password);
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  // Stream<AuthenticationStatus> get status async* {
  //   yield (user != null)
  //       ? AuthenticationStatus.authenticated
  //       : AuthenticationStatus.unauthenticated;
  //   yield* _controller.stream;
  // }

  Future<void> logIn({
    @required String email,
    @required String password,
  }) async {
    assert(email != null);
    assert(password != null);

    user = await server.login(email, password);

    preferences.saveLoginData(email, password);
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> register({
    @required String name,
    @required String email,
    @required String password,
    @required String userType,
  }) async {
    assert(name != null);
    assert(email != null);
    assert(password != null);
    assert(userType != null);

    user = await server.register(name, email, password, userType);

    preferences.saveLoginData(email, password);
    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() {
    preferences.deleteLoginData();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
