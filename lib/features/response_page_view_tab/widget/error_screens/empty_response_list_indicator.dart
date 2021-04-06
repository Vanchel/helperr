import 'package:flutter/material.dart';

class EmptyResponseListIndicator extends StatelessWidget {
  const EmptyResponseListIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Здесь пока что нет ни одного отклика.'),
      ),
    );
  }
}
