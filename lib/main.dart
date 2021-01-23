import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';
import 'data_layer/repository/authentication_repository.dart';
import 'debug/bloc_observer.dart';

void main() {
  Bloc.observer = HelperrObserver();
  runApp(
    HelperApp(authenticationRepository: AuthenticationRepository()),
  );
}
