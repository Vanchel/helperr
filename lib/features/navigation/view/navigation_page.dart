import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/navigation/cubit/navigation_cubit.dart';
import 'package:helperr/features/navigation/view/navigation_view.dart';

class NavigationPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NavigationPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: NavigationView(),
    );
  }
}
