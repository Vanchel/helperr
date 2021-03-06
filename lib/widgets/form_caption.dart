import 'package:flutter/material.dart';

class FormCaption extends StatelessWidget {
  const FormCaption({Key key, this.captionText}) : super(key: key);

  final captionText;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      children: [
        const Divider(),
        (captionText?.isNotEmpty ?? false)
            ? Text(captionText, style: themeData.textTheme.caption)
            : const SizedBox.shrink(),
      ],
    );
  }
}
