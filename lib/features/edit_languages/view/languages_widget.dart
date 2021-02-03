import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/worker.dart';
import 'package:helperr/features/edit_languages/cubit/languages_cubit.dart';
import 'package:helperr/features/edit_languages/view/languages_view.dart';

class LanguagesList extends StatelessWidget {
  const LanguagesList({Key key, this.initialValue = const [], this.onChanged})
      : super(key: key);

  final List<Language> initialValue;
  final Function(List<Language> newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguagesCubit(initialValue),
      child: LanguagesView(onChanged: onChanged),
    );
  }
}
