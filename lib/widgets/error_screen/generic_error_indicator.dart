import 'package:flutter/material.dart';
import 'exception_indicator.dart';

class GenericErrorIndicator extends StatelessWidget {
  const GenericErrorIndicator({
    Key key,
    this.onTryAgain,
  }) : super(key: key);

  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) => ExceptionIndicator(
        title: 'Что-то пошло не так',
        message: 'В приложении возникла неизвестная ошибка. '
            'Пожалуйста, повторите попытку позже.',
        assetName: 'assets/unknown-error.svg',
        onTryAgain: onTryAgain,
      );
}
