import 'package:flutter/material.dart';
import 'package:helperr/data_layer/model/vacancy.dart';

class EditVacancyView extends StatefulWidget {
  EditVacancyView({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.vacancy,
  }) : super(key: key);

  final VoidCallback onSave;
  final bool isEditing;
  final Vacancy vacancy;

  @override
  _EditVacancyViewState createState() => _EditVacancyViewState();
}

class _EditVacancyViewState extends State<EditVacancyView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Работаем')),
      body: Container(child: Center(child: const Text('Работаем'))),
    );
  }
}
