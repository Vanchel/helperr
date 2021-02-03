import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/features/edit_social_links/cubit/social_links_cubit.dart';
import 'package:helperr/features/edit_social_links/view/social_links_view.dart';

class SocialLinksList extends StatelessWidget {
  const SocialLinksList({Key key, this.initialValue = const [], this.onChanged})
      : super(key: key);

  final List<String> initialValue;
  final Function(List<String> newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLinksCubit(initialValue),
      child: SocialLinksView(onChanged: onChanged),
    );
  }
}
