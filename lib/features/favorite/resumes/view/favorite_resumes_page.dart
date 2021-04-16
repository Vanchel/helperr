import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorite_resumes_view.dart';
import '../cubit/favorite_resumes_cubit.dart';

class FavoriteResumesPage extends StatelessWidget {
  const FavoriteResumesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteResumesCubit(),
      child: FavoriteResumesView(),
    );
  }
}
