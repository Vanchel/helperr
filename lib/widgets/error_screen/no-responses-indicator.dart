import 'package:flutter/cupertino.dart';
import 'exception_indicator.dart';

class NoResponsesIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const ExceptionIndicator(
        title: 'Список откликов пуст',
        message: 'Здесь пока что ничего нет. '
            'Поработайте над тем, чтобы это исправить.',
        assetName: 'assets/no-responses.svg',
      );
}
