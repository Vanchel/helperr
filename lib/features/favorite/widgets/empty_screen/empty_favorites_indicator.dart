import 'package:flutter/material.dart';

class EmptyFavoritesIndicator extends StatelessWidget {
  const EmptyFavoritesIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('В Вашем списке избранного пока пусто.'),
      ),
    );
  }
}
