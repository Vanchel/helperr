import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/widgets/custom_back_button.dart';

import '../cubit/settings_cubit.dart';
import '../../../constants.dart' as c;

class SettingsView extends StatelessWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Настройки'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(c.scaffoldBodyPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(),
            Container(
              height: c.bigButtonHeight,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(primary: Colors.red),
                icon: const Icon(Icons.logout),
                label: const Text(
                  'Выйти',
                  style: TextStyle(fontSize: c.bigButtonFontSize),
                ),
                onPressed: () => context.read<SettingsCubit>().logout(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
