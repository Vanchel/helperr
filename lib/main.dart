import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';
import 'bloc_observer.dart';
import 'data_layer/repository/authentication_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = HelperrObserver();
  runApp(HelperApp(authenticationRepository: AuthenticationRepository()));
}
