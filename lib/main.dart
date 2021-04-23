import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:helperr/data_layer/data_provider/authentication_api_client.dart';
import 'package:helperr/data_layer/data_provider/regular_api_client.dart';
import 'package:http/http.dart' as http;

import 'app.dart';
import 'bloc_observer.dart';
import 'data_layer/repository/authentication_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = HelperrObserver();

  final httpClient = http.Client();
  final authenticationApiClient = AuthenticationApiClient(
    httpClient: httpClient,
  );
  final authenticationRepository = AuthenticationRepository(
    authenticationApiClient: authenticationApiClient,
  );

  RegularApiClient.httpClient = httpClient;
  RegularApiClient.onUnauthorized = () => authenticationRepository.logOut();
  RegularApiClient.getAuthToken = () => authenticationApiClient.accessToken;
  RegularApiClient.updateTokens =
      () async => await authenticationApiClient.refreshCurrentToken();

  runApp(HelperApp(authenticationRepository: authenticationRepository));
}
