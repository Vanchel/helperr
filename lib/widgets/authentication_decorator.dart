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
            constraints: const BoxConstraints(
              maxWidth: constants.deviceWidthBreakpoint,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(constants.scaffoldBodyPadding),
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
