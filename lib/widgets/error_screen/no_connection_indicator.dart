import 'package:flutter/cupertino.dart';
import 'exception_indicator.dart';

class NoConnectionIndicator extends StatelessWidget {
  const NoConnectionIndicator({
    Key key,
    this.onTryAgain,
  }) : super(key: key);

  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) => ExceptionIndicator(
        title: 'Отсутствует интернет-соединение',
        message: 'Пожалуйста, проверьте, подключены ли Вы к интернету, '
            'и повторите попытку.',
        assetName: 'assets/no-connection.svg',
        onTryAgain: onTryAgain,
      );
}
