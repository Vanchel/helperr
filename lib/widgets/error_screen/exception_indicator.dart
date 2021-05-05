import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart' as c;

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
    final deviceHeight = MediaQuery.of(context).size.height;

    final spacer = SizedBox(height: deviceHeight * 0.2);

    final image = SvgPicture.asset(
      assetName,
      height: deviceHeight * 0.15,
      //color: theme.accentColor,
    );

    final titleWidget = Container(
      margin: const EdgeInsets.only(top: c.defaultMargin),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),
    );

    Widget messageWidget;
    if (message?.isNotEmpty ?? false) {
      messageWidget = Container(
        margin: const EdgeInsets.only(top: c.defaultMargin),
        child: Text(message, textAlign: TextAlign.center),
      );
    } else {
      messageWidget = const SizedBox.shrink();
    }

    Widget retryButton;
    if (onTryAgain != null) {
      retryButton = Container(
        margin: const EdgeInsets.only(top: c.defaultMargin),
        child: TextButton(
          onPressed: onTryAgain,
          child: const Text('Попробовать снова'),
        ),
      );
    } else {
      retryButton = const SizedBox.shrink();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(c.scaffoldBodyPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          spacer,
          image,
          titleWidget,
          messageWidget,
          retryButton,
          spacer,
        ],
      ),
    );
  }
}
