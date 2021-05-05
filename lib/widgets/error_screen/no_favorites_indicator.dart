import 'package:flutter/cupertino.dart';
import 'exception_indicator.dart';

class NoFavoritesIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const ExceptionIndicator(
        title: 'Список избранного пуст',
        message: 'Вы пока что не добавили ничего в избранное.',
        assetName: 'assets/no-favorites.svg',
      );
}
