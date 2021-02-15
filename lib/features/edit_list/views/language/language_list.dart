import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'language_view.dart';
import '../../cubit/edit_cubit.dart';
import '../../../../data_layer/model/worker.dart';

class LanguageList extends StatelessWidget {
  const LanguageList({Key key, this.initialValue = const [], this.onChanged})
      : super(key: key);

  final List<Language> initialValue;
  final void Function(List<Language> newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditListCubit(initialValue),
      child: LanguageView(onChanged: onChanged),
    );
  }
}
