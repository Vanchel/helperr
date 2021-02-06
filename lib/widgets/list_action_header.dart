import 'package:flutter/material.dart';

class ListActionHeader extends StatelessWidget {
  const ListActionHeader(
    this.title, {
    Key key,
    this.titleStyle,
    this.actionLabel,
    this.action,
  })  : assert(title != null),
        super(key: key);

  final String title;
  final TextStyle titleStyle;
  final String actionLabel;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: titleStyle ?? themeData.textTheme.bodyText1),
        OutlinedButton(child: Text(actionLabel), onPressed: action),
      ],
    );
  }
}
