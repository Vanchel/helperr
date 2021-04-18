import 'package:flutter/material.dart';

import '../constants.dart' as c;

class ListAddHeader extends StatelessWidget {
  const ListAddHeader(
    this.title, {
    Key key,
    this.action,
  })  : assert(title != null),
        super(key: key);

  final String title;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: themeData.textTheme.subtitle1,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline_rounded),
          color: themeData.primaryColor,
          splashRadius: c.iconButtonSplashRadius,
          onPressed: action,
        ),
      ],
    );
  }
}
