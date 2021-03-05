import 'package:flutter/material.dart';

import '../constants.dart' as constants;

class AuthenticationDecorator extends StatelessWidget {
  AuthenticationDecorator({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center(
          child: Container(
            margin:
                const EdgeInsets.all(constants.DEFAULT_SCAFFOLD_BODY_PADDING),
            constraints: const BoxConstraints(
              maxWidth: constants.DEVICE_SIZE_BREAKPOINT,
            ),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: SingleChildScrollView(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
