import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  ErrorScreen({Key key, @required this.onRetry}) : super(key: key);

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Произошла ошибка'),
            TextButton(
              child: const Text('Повторить попытку'),
              onPressed: () {
                if (onRetry != null) {
                  onRetry();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
