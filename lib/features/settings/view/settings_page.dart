import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SettingsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: Container(
        child: Center(
          child: const Text('Knock-knock... -Who\'s there? -Settings!'),
        ),
      ),
    );
  }
}
