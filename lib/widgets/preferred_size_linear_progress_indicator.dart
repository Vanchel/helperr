import 'package:flutter/material.dart';

const double _height = 6.0;

class PrefferedSizeLinearProgressIndicator extends LinearProgressIndicator
    implements PreferredSizeWidget {
  const PrefferedSizeLinearProgressIndicator({
    Key key,
    double value,
    Color backgroundColor,
    Animation<Color> valueColor,
  }) : super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          valueColor: valueColor,
        );

  @override
  final preferredSize = const Size(double.infinity, _height);
}
