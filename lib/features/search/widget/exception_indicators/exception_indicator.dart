import 'package:flutter/material.dart';

import '../../../../constants.dart' as c;

class ExceptionIndicator extends StatelessWidget {
  const ExceptionIndicator({
    @required this.title,
    @required this.assetName,
    this.message,
    this.onTryAgain,
    Key key,
  })  : assert(title != null),
        assert(assetName != null),
        super(key: key);
  final String title;
  final String message;
  final String assetName;
  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) {
    final image = Container(
      margin: const EdgeInsets.only(bottom: c.defaultMargin),
      child: Image.asset(assetName),
    );

    final titleWidget = Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline6,
    );

    Widget messageWidget;
    if (message.isNotEmpty ?? false) {
      messageWidget = Container(
        margin: const EdgeInsets.only(top: c.defaultMargin),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      );
    } else {
      messageWidget = const SizedBox.shrink();
    }

    Widget spacer;
    if (onTryAgain != null) {
      spacer = const Spacer();
    } else {
      spacer = const SizedBox.shrink();
    }

    Widget retryButton;
    if (onTryAgain != null) {
      retryButton = Container(
        height: c.bigButtonHeight,
        child: ElevatedButton.icon(
          onPressed: onTryAgain,
          icon: const Icon(Icons.refresh_rounded),
          label: const Text(
            'Попробовать снова',
            style: TextStyle(
              fontSize: c.bigButtonFontSize,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      retryButton = const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(c.scaffoldBodyPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          image,
          titleWidget,
          messageWidget,
          spacer,
          retryButton,
        ],
      ),
    );
  }
}
