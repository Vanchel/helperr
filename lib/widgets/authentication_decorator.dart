import 'package:flutter/material.dart';

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
            margin: const EdgeInsets.all(12.0),
            constraints: const BoxConstraints(maxWidth: 400.0),
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
