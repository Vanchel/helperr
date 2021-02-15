import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'social_link_view.dart';
import '../../cubit/edit_cubit.dart';

class SocialLinkList extends StatelessWidget {
  const SocialLinkList({Key key, this.initialValue = const [], this.onChanged})
      : super(key: key);

  final List<String> initialValue;
  final void Function(List<String> newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditListCubit(initialValue),
      child: SocialLinkView(onChanged: onChanged),
    );
  }
}
