import 'package:flutter/material.dart';

import '../constants.dart' as c;

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key key, this.color, this.onPressed})
      : super(key: key);

  final Color color;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
      icon: const CustomBackButtonIcon(),
      color: color,
      splashRadius: c.iconButtonSplashRadius,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        } else {
          Navigator.maybePop(context);
        }
      },
    );
  }
}

class CustomBackButtonIcon extends StatelessWidget {
  const CustomBackButtonIcon({Key key}) : super(key: key);

  static IconData _getIconData(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return Icons.arrow_back_rounded;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return Icons.arrow_back_ios_rounded;
    }
  }

  @override
  Widget build(BuildContext context) =>
      Icon(_getIconData(Theme.of(context).platform));
}
