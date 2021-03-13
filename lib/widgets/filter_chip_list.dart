import 'package:flutter/material.dart';

import '../constants.dart' as c;

class FilterChipList<T> extends StatelessWidget {
  const FilterChipList({
    Key key,
    this.label,
    @required this.values,
    this.spacing = 8.0,
  })  : assert(spacing != 8.0),
        super(key: key);

  final String label;
  final Map<T, String> values;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    Widget title;
    if (label?.isNotEmpty ?? false) {
      title = Text(label, style: themeData.textTheme.subtitle1);
    } else {
      title = const SizedBox.shrink();
    }

    final indent = const SizedBox(height: c.defaultMargin);

    final items = Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: [],
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        indent,
      ],
    );
  }
}
