import 'package:flutter/material.dart';

import '../constants.dart' as constants;

class EditPageAppbar extends StatelessWidget with PreferredSizeWidget {
  static const progressIndicatorHeight = 4.0;

  const EditPageAppbar({
    Key key,
    this.title,
    this.onSave,
    this.showProgressIndicator = false,
  })  : assert(showProgressIndicator != null),
        toolbarHeight = showProgressIndicator
            ? kToolbarHeight - progressIndicatorHeight
            : kToolbarHeight,
        super(key: key);

  final String title;
  final VoidCallback onSave;
  final bool showProgressIndicator;

  final double toolbarHeight;

  @override
  Widget build(BuildContext context) {
    final titleWidget = (title?.isNotEmpty ?? false) ? Text(title) : null;

    final backButton = IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      splashRadius: constants.iconButtonSplashRadius,
      onPressed: () => Navigator.pop(context),
    );

    final saveButton = IconButton(
      icon: const Icon(Icons.check_rounded),
      splashRadius: constants.iconButtonSplashRadius,
      onPressed: onSave,
    );

    Widget progressIndicator;
    if (showProgressIndicator) {
      progressIndicator = const PreferredSize(
        preferredSize: Size.fromHeight(progressIndicatorHeight),
        child: LinearProgressIndicator(),
      );
    } else {
      progressIndicator = null;
    }

    return AppBar(
      leading: backButton,
      title: titleWidget,
      actions: [saveButton],
      toolbarHeight: toolbarHeight,
      bottom: progressIndicator,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
