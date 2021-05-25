import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorite_cubit.dart';
import '../../../../../constants.dart' as c;

class FavoriteButtonView extends StatelessWidget {
  const FavoriteButtonView({
    Key key,
    @required this.onChanged,
  }) : super(key: key);

  final void Function(bool newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text('Произошла ошибка'),
            ));
        } else {
          if (onChanged != null) {
            onChanged(state.isInFavorite);
          }
        }
      },
      builder: (context, state) {
        final theme = Theme.of(context);

        return IconButton(
          icon: Icon(state.isInFavorite
              ? Icons.favorite_rounded
              : Icons.favorite_outline_rounded),
          color: state.isInFavorite ? theme.accentColor : theme.disabledColor,
          splashRadius: c.iconButtonSplashRadius,
          onPressed: () => context.read<FavoriteCubit>().changeState(),
        );
      },
    );
  }
}
