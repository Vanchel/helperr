import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:helperr/theme.dart';

import 'data_layer/repository/authentication_repository.dart';
import 'features/authentication/bloc/authentication_bloc.dart';
import 'features/login/view/login_page.dart';
import 'features/navigation/view/navigation_page.dart';
import 'features/splash/view/splash_page.dart';

class HelperApp extends StatelessWidget {
  const HelperApp({
    Key key,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      theme: lightTheme,
      darkTheme: darkTheme,
      //debugShowMaterialGrid: true,
      //showSemanticsDebugger: true,
      //showPerformanceOverlay: true,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ru', ''),
      ],
      onGenerateRoute: (_) => SplashPage.route(),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          child: child,
          listener: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              _navigator.pushAndRemoveUntil<void>(
                NavigationPage.route(),
                (route) => false,
              );
            } else if (state.status == AuthenticationStatus.unauthenticated) {
              _navigator.pushAndRemoveUntil<void>(
                LoginPage.route(),
                (route) => false,
              );
            }
          },
        );
      },
    );
  }
}
