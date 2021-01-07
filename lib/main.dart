import 'package:flutter/widgets.dart';

import 'data_layer/authentication_repository/authentication_repository.dart';
import 'data_layer/user_repository/user_repository.dart';
import 'app.dart';

void main() {
  runApp(HelperApp(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}
